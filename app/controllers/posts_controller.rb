class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
      user_posts_path(current_user.user_id),
      new_post_path,
      @post,
      '投稿に成功しました'
    )
  end

  # GET /posts/index
  # 記事一覧を表示
  def index
    @posts = Post.all.order(created_at: :desc)
    @comment_count = Post.joins(:comments).group('comments.post_id').count
  end

  # GET /posts/:post_id/edit
  def edit
    @user = User.find(current_user.id)
    @post = Post.find_by(user_id: @user.id)
    @categorys = Category.where(user_id: @user.id)
  end

  # PATCH /posts/:post_id
  # 記事の更新
  def update
    # カテゴリー未選択の場合、カテゴリー"なし"を追加
    if params[:post][:category_id] == '0'
      @none_category = Category.find_by(name: 'none', user_id: current_user.id)
      @none_category = save_none_category(current_user.id) if @none_category.nil?
      params[:post][:category_id] = @none_category.id
    end

    @post = Post.find(params[:id])
    @post.content = params[:post][:content]
    @post.title = params[:post][:title]
    @post.mst_status_id = params[:post][:mst_status_id]
    @post.category_id = params[:post][:category_id]


    model_save_and_redirect(
      user_posts_path(current_user.user_id),
      edit_post_path(@post.id),
      @post,
      '記事を更新しました'
    )
  end

  # DELETE /posts/:post_id/destroy
  # 記事の削除
  def destroy
    @post = Post.find(params[:id])
    model_destroy_and_redirect(
      user_posts_path(@post.user_id),
      user_posts_path(@post.user_id),
      @post,
      "記事「#{@post.title}」を削除しました"
    )
  end

  # GET /post/:post_id
  # 記事の詳細を表示
  def show
    @post = Post.find(params[:id])
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
