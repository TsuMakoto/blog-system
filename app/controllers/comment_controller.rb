class CommentController < ApplicationController
  before_action :authenticate_user!, only: [:new, :destroy, :update]

  # POST /comment/:post_id/new
  # コメントの新規投稿
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new(
      user_id: current_user.id,
      post_id: @post.id,
      block_flg: 0,
      content: params[:comment]
    )
    model_save_and_redirect(
      "/posts/#{@post.id}",
      "posts/#{@post.id}",
      @comment,
      'コメントを投稿しました'
    )
  end

  # DELETE /comment/:comment_id
  # コメントの削除
  def destroy
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(@comment.post_id)
    model_destroy_and_redirect(
      "/posts/#{@post.id}",
      "/posts/#{@post.id}",
      @comment,
      'コメントを削除しました'
    )
  end

  # PATCH /comment/:comment_id
  # コメントの更新
  def update
    @comment = Comment.find(params[:comment_id])
    @comment.content = params[:update_comment]
    @post = Post.find(@comment.post_id)

    model_save_and_redirect(
      "/posts/#{@post.id}",
      "posts/#{@post.id}",
      @comment,
      'コメントを更新しました'
    )
  end
end
