class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:top]

  # トップページを表示
  # ユーサー情報があればユーザのホームへ遷移する
  def top
    redirect_to("/#{current_user.user_id}")
  end

  # GET /:user_id
  # ユーザのホームを表示
  def user
    @user = User.find_by(user_id: params[:user_id])
    @posts = Post.where(user_id: @user.id).order(created_at: 'desc').limit(5)
    @comments = Comment.all.order(created_at: 'desc').limit(5)
  end
end
