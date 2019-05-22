class UsersController < ApplicationController
  # GET /:user_id
  # ユーザのホームを表示
  def show
    @user = User.find_by(user_id: params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:posts_page]).per(3)
    @comments = @user.comments.order(created_at: :desc).page(params[:comments_page]).per(3)
  end
end
