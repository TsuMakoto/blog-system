class CommentController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    if current_user.nil?
      redirect_to('/users/sign_in')
    else
      @comment = Comment.new(
        user_id: current_user.id,
        post_id: @post.id,
        block_flg: 0,
        content: params[:comment]
      )
      model_save_and_redirect(
        "/posts/#{@post.id}/detail",
        "posts/#{@post.id}/detail",
        @comment
      )
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(@comment.post_id)
    model_destroy_and_redirect("/posts/#{@post.id}/detail", "/posts/#{@post.id}/detail", @comment)
  end

end
