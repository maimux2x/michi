class PostsController < ApplicationController
  allow_unauthenticated_access(only: %i[index show])

  def index
    @pagy, @posts = pagy Post.order(created_at: :desc)
    @posts = Post.search(params[:search]) if params[:search]
  end

  def show
    @post = Post.find(params[:id])
  end
end
