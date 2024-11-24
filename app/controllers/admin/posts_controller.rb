class Admin::PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to admin_root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to admin_root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Post.find(params[:id]).destroy!

    redirect_to admin_root_path
  end

  private

  def post_params
    params.expect(post: %i[title body])
  end
end
