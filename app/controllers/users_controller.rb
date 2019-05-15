class UsersController < ApplicationController
  # GET /:user_id
  # ユーザのホームを表示
  def show
    @user = User.find_by(user_id: params[:id])
  end
end
