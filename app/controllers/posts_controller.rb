class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  # GET /posts/new
  # 記事の新規投稿画面
  def new
    @post = Post.new
  end

  # POST /posts/create
  # 新規記事投稿
  def create
    set_category_id
    @post = current_user.posts.build(post_params)
    @post.post_time = Time.zone.today # TODO: 不要なので削除予定

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
  end

  # GET /posts/:id/edit
  def edit
    @post = Post.find(params[:id])
  end

  # PATCH /posts/:post_id
  # 記事の更新
  def update
    set_category_id
    @post = Post.find(params[:id])
    model_update_and_redirect(
      user_posts_path(current_user.user_id),
      edit_post_path(@post.id),
      @post,
      post_params,
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
    @comment = Comment.new
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
    @none_category if @none_category.save
  end

  # カテゴリー未選択の場合、カテゴリー"none"を追加
  # TODO: カテゴリ選択ができるように実装
  # 今は全てnoneで登録
  def set_category_id
    category_id = params[:post][:category_id]
    unless category_id == 0
      @none_category = Category.find_by(name: 'none', user_id: current_user.id)
      @none_category = save_none_category(current_user.id) if @none_category.nil?

      params[:post][:category_id] = @none_category.id
    end
  end

  def post_params
    params
      .require(:post)
      .permit(:title, :content, :mst_status_id, :category_id)
  end

  # 編集権限がない場合、記事一覧ページへ飛ばす
  def ensure_correct_user
    @post = Post.find(params[:id])
    redirect_to(posts_path, notice: '権限がありません') unless current_user.id == @post.user_id
  end
end
