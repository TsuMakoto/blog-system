class CommentsController < ApplicationController
  before_action :authenticate_user!

  # POST /posts/:post_id/comments
  # コメントの新規投稿
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

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
    @post = @comment.post
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
    @post = @comment.post

    model_update_and_redirect(
      post_path(@post.id),
      post_path(@post.id),
      @comment,
      comment_params,
      'コメントを更新しました'
    )
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:content)
      .merge(user_id: current_user.id)
      .merge(block_flg: 0)
  end
end
