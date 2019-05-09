class PostsController < ApplicationController
  def new
    @user = User.find_by(id: params[:id])
    @post = Post.new
    @categorys = Category.all
  end

  def create
    # カテゴリー未選択の場合、カテゴリー"なし"を追加
    if params[:category].nil?
      create_none_category(params[:id])
      params[:category] = Category.find_by(name: 'none').id
    end
    @post = Post.new(
      user_id: params[:id],
      content: params[:content],
      title: params[:title],
      mst_status_id: params[:post_status].to_i,
      category_id: params[:category],
      post_time: Time.zone.today
    )
    model_save_and_redirect("/posts/#{@post.user_id}/show", "/posts/#{@post.user_id}/new", @post)
  end

  def show
    @posts = Post.all.order(created_at: :desc)
  end

  def myshow
    @posts = Post.where(user_id: params[:id].to_i)
    @categorys = Category.where(user_id: params[:id].to_i)
  end

  def edit
    @user = User.find_by(id: current_user.id)
    @post = Post.find_by(id: params[:id])
    @categorys = Category.where(user_id: @user.id)
  end

  def update
  end

  def category
  end

  private

  def create_none_category(user_id)
    @none_category = Category.find_by(name: 'none')
    if @none_category.nil?
      @none_category = Category.new(
        name: 'none',
        parent_category_id: 0,
        user_id: user_id
      )
      @none_category.save
    end
  end
end
