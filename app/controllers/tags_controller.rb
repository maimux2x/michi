class TagsController < ApplicationController
  allow_unauthenticated_access(only: :show)

  def show
    posts = Post.order(created_at: :desc).joins(:tags).where(tags: { name: params[:name] })

    @pagy, @posts = pagy(posts)
    @tag = params[:name]
  end
end
