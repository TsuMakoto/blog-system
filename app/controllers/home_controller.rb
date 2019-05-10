class HomeController < ApplicationController
  def top
    if current_user.nil?
      redirect_to('/users/sign_in')
    else
      redirect_to("/#{current_user.user_id}")
    end
  end

  def user
    @user = User.find_by(user_id: params[:user_id])
    @posts = Post.where(user_id: @user.id).order(created_at: 'DESC')
    @comments = Post.joins(:comments).select('comments.*')
  end
end
