class FeedsController < ApplicationController
  def show
    @posts = Post.order(id: :desc).includes(taggings: :tag).limit(10)
  end
end
