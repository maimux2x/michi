class PostsController < ApplicationController
  allow_unauthenticated_access(only: %i[index show])

  def index
    @posts = Post.order(created_at: :desc).limit(20)
  end

  def show
    @post = Post.find(params[:id])
  end
end
