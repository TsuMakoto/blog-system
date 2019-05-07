class PostsController < ApplicationController
  def new
    @user = User.find_by(id: params[:id])
    @post = Post.new
    @categorys = Category.all
  end

  def create
    @post = Post.new(
      user_id: params[:id],
      content: params[:content],
      title: params[:title],
      mst_status_id: 1,
      category_id: params[:category],
      post_time: Time.zone.today
    )

    if @post.save
      redirect_to("/posts/#{@post.user_id}/show")
    else
      render("/posts/#{@post.user_id}/new")
    end
  end

  def show
  end

  def all
  end

  def update
  end
end
