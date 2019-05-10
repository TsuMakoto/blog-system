class PostsController < ApplicationController
  def new
    @user = User.find_by(id: params[:id])
    @post = Post.new
    @categorys = Category.where(user_id: params[:id])
  end

  def create
    # カテゴリー未選択の場合、カテゴリー"なし"を追加
    if params[:category].nil?
      @none_category = Category.find_by(name: 'none', user_id: current_user.id)
      @none_category = save_none_category(current_user.id) if @none_category.nil?
      params[:category] = @none_category.id
    end

    @post = Post.new(
      user_id: current_user.id,
      content: params[:content],
      title: params[:title],
      mst_status_id: params[:post_status].to_i,
      category_id: params[:category],
      post_time: Time.zone.today
    )
    model_save_and_redirect(
      "/posts/#{@post.user_id}/show",
      "/posts/#{@post.user_id}/new",
      @post
    )
  end

  def show
    @posts = Post.all.order(created_at: :desc)
    @comment_count = Post.joins(:comments).group('comments.post_id').count
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

  def detail
    @post = Post.find_by(id: params[:post_id])
  end

  def comment
    @post = Post.find_by(params[:id])
    if current_user.nil?
      render("/posts/#{@post.id}/detail")
    else
      @comment = Comment.new(
        user_id: current_user.id,
        post_id: @post.id,
        block_flg: 0,
        content: params[:comment]
      )
      model_save_and_redirect(
        "/posts/#{@post.id}/detail",
        "posts/#{@post.id}/detail",
        @comment
      )
    end
  end

  private

  def save_none_category(user_id)
    @none_category = Category.new(
      name: 'none',
      parent_category_id: 0,
      user_id: user_id
    )
    return @none_category if @none_category.save
  end
end
