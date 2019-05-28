class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  # GET /post/ajax_posts
  # incremental search for index
  def ajax_posts
    @title_search = Post.ransack(
      title_cont: params[:word],
      mst_status_id_eq: setting_shared_column(val: :public),
      post_time_lt: Time.zone.now
    )
    @tag_search = Tag.ransack()
    @posts = fetch_paginated_model(
      @search.result,
      setting_model_column(model: :post, action: :index, val: :one_page_posts_index)
    )
  end

  # GET /posts/index
  # 記事一覧を表示
  def index
    @search = Post.ransack(
      title_cont: params[:q],
      mst_status_id_eq: setting_shared_column(val: :public),
      post_time_lt: Time.zone.now
    )
    @posts = fetch_paginated_model(
      @search.result,
      setting_model_column(model: :post, action: action_name, val: :one_page_posts_index)
    )

    # ajax用
    return unless request.xhr?

    render 'ajax_posts'
  end

  # POST /posts/create
  # 新規記事投稿
  def create
    @post = current_user.posts.build(post_params)

    model_save_and_redirect(
      user_posts_path(current_user.user_id),
      new_post_path,
      @post,
      t('.success_message', post_title: @post.title)
    )
  end

  # GET /posts/new
  # 記事の新規投稿画面
  def new
    @post = Post.new
  end

  # GET /posts/:id/edit
  def edit
    @post = Post.find(params[:id])
  end

  # GET /post/:post_id
  # 記事の詳細を表示
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  # PATCH /posts/:post_id
  # 記事の更新
  def update
    @post = Post.find(params[:id])
    model_update_and_redirect(
      user_posts_path(current_user.user_id),
      edit_post_path(@post.id),
      @post,
      post_params,
      t('.success_message', post_title: @post.title)
    )
  end

  # DELETE /posts/:post_id/destroy
  # 記事の削除
  def destroy
    @post = Post.find(params[:id])
    model_destroy_and_redirect(
      user_posts_path(current_user.user_id),
      user_posts_path(current_user.user_id),
      @post,
      t('.success_message', post_title: @post.title)
    )
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

  def post_params
    params
      .require(:post)
      .permit(:title, :content, :mst_status_id, :category_id, :post_time)
  end

  # 編集権限がない場合、記事一覧ページへ飛ばす
  def ensure_correct_user
    post = Post.find(params[:id])
    return if current_user.id == post.user_id

    redirect_to(posts_path, notice: t('controllers.unauthorized_error_message'))
  end
end
