class PostsController < ApplicationController
  allow_unauthenticated_access(only: %i[index show])

  def index
    posts = Post.order(created_at: :desc).includes(taggings: :tag)
    posts = posts.search(params[:search]) if params[:search]

    @pagy, @posts = pagy(posts)
  end

  def show
    @post = Post.find(params[:id])
  end
end
