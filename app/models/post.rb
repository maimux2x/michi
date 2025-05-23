class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :attachments
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  before_save :set_attachments
  after_commit :purge_unattached_blobs

  scope :search, ->(query) {
    where(
      "title LIKE :query OR body LIKE :query",
      query: "%#{sanitize_sql_like(query)}%"
    )
  }

  def to_param
    "#{id}-#{created_at.strftime("%Y%m%d")}"
  end

  def tag_names
    taggings.sort_by(&:position).map { it.tag.name }
  end

  def tag_names=(tags)
    names = tags.split(/\s+/)

    self.taggings = names.map.with_index { |name, i|
      tag = Tag.find_or_create_by!(name:)
      Tagging.new(tag:, position: i)
    }
  end

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
