class HomeController < ApplicationController
  def top
    if current_user.nil?
      redirect_to('/users/sign_in')
    else
      # サイドカラム を表示するかどうか
      @posts = Post.where(user_id: current_user.id).order(created_at: 'DESC')
      @comment_count = 0
    end
  end
end
