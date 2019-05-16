class Users::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user

  # GET /users/:user_id/posts
  # 自分の記事を表示
  def index
  end

  private

  # 編集権限がないユーザを該当記事ページへ飛ばす
  # rubocop:disable Style/MultilineIfModifier
  def ensure_correct_user
    redirect_to(
      user_posts_path(current_user.user_id),
      notice: '自分の記事へリダイレクトしました'
    ) unless current_user.user_id == params[:user_id]
  end
  # rubocop:enable Style/MultilineIfModifier
end
