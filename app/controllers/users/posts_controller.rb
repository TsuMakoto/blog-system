class Users::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  # GET /users/:user_id/posts
  # 自分の記事を表示
  def index
    redirect_my_index(current_user.user_id) if current_user.user_id != params[:user_id]

    @user = User.find_by(user_id: current_user.user_id)
    @posts = Post.where(user_id: @user.id)
  end

  private

  # /users/:user_id/postsへリダイレクトする
  # ==== Args
  # user_id :: ユーザID
  def redirect_my_index(user_id)
    redirect_to(
      user_posts_path(user_id),
      alert: '自分の記事へリダイレクトしました'
    )
  end
end
