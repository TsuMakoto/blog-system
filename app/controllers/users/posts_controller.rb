class Users::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user

  # GET /users/:user_id/posts
  # 自分の記事を表示
  def index
    @posts = current_user.posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  # 編集権限がないユーザを該当記事ページへ飛ばす
  def ensure_correct_user
    return if current_user.user_id == params[:user_id]

    redirect_to(
      user_posts_path(current_user.user_id),
      notice: '自分の記事へリダイレクトしました'
    )
  end
end
