class UsersController < ApplicationController
  # GET /:user_id
  # ユーザのホームを表示
  def show
    @user = User.find_by(user_id: params[:id])
    @search = @user.posts.ransack(params[:q])
    @posts =
      fetch_paginated_model_order_date(
        :desc,
        setting_model_column(model: :post, action: action_name, val: :user_posts_index),
        params[:posts_page],
        @search.result
      )
    @comments =
      fetch_paginated_model_order_date(
        :desc,
        setting_model_column(model: :comment, action: action_name, val: :user_comments_index),
        params[:comments_page],
        @user.comments
      )
  end
end
