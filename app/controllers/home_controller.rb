class HomeController < ApplicationController

  # トップページを表示
  # ユーサー情報があればユーザのホームへ遷移する
  def top
    if current_user.nil?
      redirect_to('/users/sign_in')
    else
      redirect_to("/#{current_user.user_id}")
    end
  end

  # GET /:user_id
  # ユーザのホームを表示
  def user
    @user = User.find_by(user_id: params[:user_id])
    @posts = Post.where(user_id: @user.id).order(created_at: 'DESC')
    @comments = Post.joins(:comments).select('comments.*')
  end
end
