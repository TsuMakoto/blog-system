class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :myposts]
  # GET /posts/new
  # 記事の新規投稿画面
  def new
    @post = Post.new
    @categorys = Category.where(user_id: current_user.id)
  end

  # POST /posts/create
  # 新規記事投稿
  def create
    # カテゴリー未選択の場合、カテゴリー"none"を追加
    # TODO: カテゴリ選択ができるように実装
    # 今は全てnoneで登録
    if params[:category_id] == '0'
      @none_category = Category.find_by(name: 'none', user_id: current_user.id)
      @none_category = save_none_category(current_user.id) if @none_category.nil?
      params[:category_id] = @none_category.id
    end

    @post = Post.new(
      user_id: current_user.id,
      content: params[:content],
      title: params[:title],
      mst_status_id: params[:mst_status_id].to_i,
      category_id: params[:category_id],
      post_time: Time.zone.today
    )

    @categorys = Category.where(user_id: current_user.id)
    model_save_and_redirect(
      "/#{current_user.user_id}/posts/show",
      'posts/new',
      @post,
      '投稿に成功しました'
    )
  end

  # GET /posts/show
  # 記事一覧を表示
  def show
    @posts = Post.all.order(created_at: :desc)
    @comment_count = Post.joins(:comments).group('comments.post_id').count
  end

  # GET /posts/:user_id/show
  # 自分の記事を表示
  def myposts
    redirect_to("/#{current_user.user_id}/posts/show") if current_user.user_id != params[:user_id]

    @user = User.find_by(user_id: current_user.user_id)
    @posts = Post.where(user_id: @user.id)
    @categorys = Category.where(user_id: params[:id].to_i)
  end

  def edit
    @user = User.find(current_user.id)
    @post = Post.find(params[:post_id])
    @categorys = Category.where(user_id: @user.id)
  end

  # POST /posts/:post_id/update
  # 記事の更新
  def update
    # カテゴリー未選択の場合、カテゴリー"なし"を追加
    if params[:post][:category] == '0'
      @none_category = Category.find_by(name: 'none', user_id: current_user.id)
      @none_category = save_none_category(current_user.id) if @none_category.nil?
      params[:post][:category] = @none_category.id
    end

    @post = Post.find(params[:post_id])
    @post.content = params[:post][:content]
    @post.title = params[:post][:title]
    @post.mst_status_id = params[:post][:mst_status_id]
    @post.category_id = params[:post][:category_id]

    model_save_and_redirect(
      "/#{@post.user_id}/posts/show",
      "/posts/#{@post.id}/edit",
      @post,
      '記事を更新しました'
    )
  end

  # POST /posts/:post_id/destroy
  # 記事の削除
  def destroy
    @post = Post.find(params[:post_id])
    model_destroy_and_redirect(
      "/#{@post.user_id}/posts/show",
      "/#{@post.user_id}/post/sshow",
      @post,
      "記事「#{@post.title}」を削除しました"
    )
  end

  # GET /post/:post_id/detail
  # 記事の詳細を表示
  def detail
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post_id: @post.id)
  end

  private

  # カテゴリー未選択で、登録済みカテゴリがない場合、
  # noneとしてカテゴリを登録
  def save_none_category(user_id)
    @none_category = Category.new(
      name: 'none',
      parent_category_id: 0,
      user_id: user_id
    )
    return @none_category if @none_category.save
  end
end
