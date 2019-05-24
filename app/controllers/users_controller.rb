class UsersController < ApplicationController
  # GET /users/:user_id
  # ユーザのホームを表示
  def show
    @user = User.find_by(user_id: params[:id])
    @search = @user.posts.ransack(params[:q])
    @posts =
      fetch_paginated_model(
        @search.result,
        setting_model_column(model: :post, action: action_name, val: :user_posts_index),
        params[:posts_page]
      )
    @comments =
      fetch_paginated_model(
        @user.comments,
        setting_model_column(model: :comment, action: action_name, val: :user_comments_index),
        params[:comments_page]
      )

    # ajax用
    return unless request.xhr?

    render 'ajax_posts'
  end

  # GET /users/:user_id/ajax_posts
  # incremental search for show
  def ajax_posts
    @user = User.find_by(user_id: params[:user_id])
    @search = @user.posts.ransack(title_cont: params[:word])
    @posts =
      fetch_paginated_model(
        @search.result,
        setting_model_column(model: :post, action: :show, val: :user_posts_index),
        params[:posts_page]
      )
  end
end
