class UsersController < ApplicationController
  # GET /:user_id
  # ユーザのホームを表示
  def show
    @user = User.find_by(user_id: params[:id])
    @posts = @user.posts.page(params[:posts_page]).per(3).order(created_at: :desc)
    @comments = @user.comments.page(params[:comments_page]).per(3).order(created_at: :desc)
  end

  private

  # 取得数を制限
  def limited_model(model)
    model.order(created_at: :desc).limit(5)
  end
end
