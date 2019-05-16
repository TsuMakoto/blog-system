class UsersController < ApplicationController
  # GET /:user_id
  # ユーザのホームを表示
  def show
    @user = User.find_by(user_id: params[:id])
    @limited_model_posts = limited_model(@user.posts)
    @limited_model_comments = limited_model(@user.comments)
  end

  private

  # 取得数を制限
  def limited_model(model)
    model.order(created_at: :desc).limit(5)
  end
end
