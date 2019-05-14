class CommentController < ApplicationController
  before_action :authenticate_user!, only: [:new]

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
      "/posts/#{@post.id}/detail",
      "posts/#{@post.id}/detail",
      @comment,
      'コメントを投稿しました'
    )
  end

  # POST /comment/:comment_id/destroy
  # コメントの削除
  def destroy
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(@comment.post_id)
    model_destroy_and_redirect(
      "/posts/#{@post.id}/detail",
      "/posts/#{@post.id}/detail",
      @comment,
      'コメントを削除しました'
    )
  end

  # POST /comment/:comment_id/update
  # コメントの更新
  def update
    @comment = Comment.find(params[:comment_id])
    @comment.content = params[:update_comment]
    @post = Post.find(@comment.post_id)

    model_save_and_redirect(
      "/posts/#{@post.id}/detail",
      "posts/#{@post.id}/detail",
      @comment,
      'コメントを更新しました'
    )
  end
end
