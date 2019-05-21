module PostsHelper
  def comment_edit(comment_id)
    "comment-edit#{comment_id}"
  end

  def comment_content(comment_id)
    "comment-content#{comment_id}"
  end
end
