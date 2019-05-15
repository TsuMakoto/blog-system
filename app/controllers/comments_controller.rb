class CommentsController < ApplicationController
  before_action :authenticate_user!

  # POST /posts/:post_id/comments
  # コメントの新規投稿
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(
      user_id: current_user.id,
      post_id: @post.id,
      block_flg: 0,
      content: params[:comment]
    )
    model_save_and_redirect(
      post_path(@post.id),
      post_path(@post.id),
      @comment,
      'コメントを投稿しました'
    )
  end

  # DELETE /comment/:comment_id
  # コメントの削除
  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    model_destroy_and_redirect(
      post_path(@post.id),
      post_path(@post.id),
      @comment,
      'コメントを削除しました'
    )
  end

  # PATCH /comment/:comment_id
  # コメントの更新
  def update
    @comment = Comment.find(params[:id])
    @comment.content = params[:update_comment]
    @post = Post.find(@comment.post_id)

    model_save_and_redirect(
      post_path(@post.id),
      post_path(@post.id),
      @comment,
      'コメントを更新しました'
    )
  end
end
