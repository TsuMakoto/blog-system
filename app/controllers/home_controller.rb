class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:top]

  # トップページを表示
  # ユーサー情報があればユーザのホームへ遷移する
  def top
    redirect_to(user_path(current_user.user_id))
  end
end
