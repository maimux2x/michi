class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :attachments

  before_save :set_attachments
  after_commit :purge_unattached_blobs

  def rendered_body
    return "" unless body

    Commonmarker.to_html(body).html_safe
  end

  def next
    Post.where("id > ?", id).order(:id).first
  end

  def previous
    Post.where("id < ?", id).order(id: :desc).first
  end

  private

  def set_attachments
    signed_ids = []

    Commonmarker.parse(body).walk do |node|
      case node.type
      when :link, :image
        if %r{\A/rails/active_storage/blobs/(?:redirect/|proxy/)?(?<signed_id>\S+)/} =~ node.url
          signed_ids << signed_id
        end
      end
    end

    self.attachments = signed_ids
  end

  def purge_unattached_blobs
    ActiveStorage::Blob.unattached.each(&:purge)
  end
end
