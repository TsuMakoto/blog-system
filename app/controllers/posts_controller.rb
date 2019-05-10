class PostsController < ApplicationController
  def new
    @categorys = Category.where(user_id: current_user.id)
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
      "/#{current_user.user_id}/posts/show",
      '/posts/new',
      @post
    )
  end

  def show
    @posts = Post.all.order(created_at: :desc)
    @comment_count = Post.joins(:comments).group('comments.post_id').count
  end

  def myposts
    redirect_to("/#{current_user.user_id}/posts/show") if current_user.user_id != params[:user_id]

    @user = User.find_by(user_id: params[:user_id])
    @posts = Post.where(user_id: @user.id)
    @categorys = Category.where(user_id: params[:id].to_i)
  end

  def edit
    @user = User.find(current_user.id)
    @post = Post.find(params[:post_id])
    @categorys = Category.where(user_id: @user.id)
  end

  def update
    # カテゴリー未選択の場合、カテゴリー"なし"を追加
    if params[:category].nil?
      @none_category = Category.find_by(name: 'none', user_id: current_user.id)
      @none_category = save_none_category(current_user.id) if @none_category.nil?
      params[:category] = @none_category.id
    end

    @post = Post.find(params[:post_id])
    @post.content = params[:content]
    @post.title = params[:title]
    @post.mst_status_id = params[:post_status]
    @post.category_id = params[:category]

    model_save_and_redirect(
      "/posts/#{@post.user_id}/show",
      "/posts/#{@post.id}/edit",
      @post
    )
  end

  def destroy
    @post = Post.find(params[:post_id])
    model_destroy_and_redirect(
      "/posts/#{@post.user_id}/show",
      "/posts/#{@post.user_id}/show",
      @post
    )
  end

  def detail
    @post = Post.find_by(id: params[:post_id])
    @comments = Comment.where(post_id: @post.id)
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
