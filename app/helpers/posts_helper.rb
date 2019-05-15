module PostsHelper
  def get_id_edit_comment(comment_id)
    "edit-comment-area#{comment_id}"
  end

  def get_id_comment_content(comment_id)
    "comment-content#{comment_id}"
  end
end
