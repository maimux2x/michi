class FeedsController < ApplicationController
  allow_unauthenticated_access(only: %i[show])

  def show
    @posts = Post.order(id: :desc).includes(taggings: :tag).limit(10)
  end
end
