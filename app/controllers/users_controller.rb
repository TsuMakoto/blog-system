class UsersController < ApplicationController
  # GET /:user_id
  # ユーザのホームを表示
  def show
    @user = User.find_by(user_id: params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: 'desc').limit(5)
    @comments = Comment.all.order(created_at: 'desc').limit(5)
  end
end
