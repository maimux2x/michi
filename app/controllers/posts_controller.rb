class PostsController < ApplicationController
  allow_unauthenticated_access(only: %i[index show])

  def index
    @pagy, @posts = pagy Post.order(created_at: :desc).includes(taggings: :tag)
    @pagy, @posts = pagy Post.search(params[:search]) if params[:search]
  end

  def show
    @post = Post.find(params[:id])
  end

  def tag
    @pagy, @posts = pagy Post.order(created_at: :desc).joins(:tags).where(tags: { name: params[:tag] })

    render :index
  end
end
