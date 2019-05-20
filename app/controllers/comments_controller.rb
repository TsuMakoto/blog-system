class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :destroy]

  # POST /posts/:post_id/comments
  # コメントの新規投稿
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    model_save_and_redirect(
      post_path(@post.id),
      post_path(@post.id),
      @comment,
      t('.success_message')
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
      t('.success_message')
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
      t('.success_message')
    )
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:content)
  end

  # 編集権限がないユーザを該当記事ページへ飛ばす
  # rubocop:disable Metrics/AbcSize
  def ensure_correct_user
    comment = Comment.find(params[:id])

    if action_name == 'destroy'
      if comment.user.id != current_user.id && comment.post.user.id != current_user.id
        redirect_to(
          post_path(comment.post.id),
          notice: t('controllers.unauthorized_error_message')
        )
      end
    elsif comment.user.id != current_user.id
      redirect_to(
        post_path(comment.post.id),
        notice: t('controllers.unauthorized_error_message')
      )
    end
  end
  # rubocop:enable  Metrics/AbcSize
end
