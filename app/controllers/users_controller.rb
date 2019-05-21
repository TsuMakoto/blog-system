class UsersController < ApplicationController
  # GET /:user_id
  # ユーザのホームを表示
  def show
    @user = User.find_by(user_id: params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(5)
    @comments = @user.comments.order(created_at: :desc).page(params[:page]).per(5)
  end

  private

  # 取得数を制限
  def limited_model(model)
    model.order(created_at: :desc).limit(5)
  end
end
