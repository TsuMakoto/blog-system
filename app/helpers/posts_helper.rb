module PostsHelper
  def comment_edit(comment_id)
    "comment-edit#{comment_id}"
  end

  def comment_content(comment_id)
    "comment-content#{comment_id}"
  end

  # 検索するカラム名から検索ボックスを作成
  # @param [] form 検索フォーム
  # @param [String] search_content_name 検索対象名
  def create_search_field(form, search_content_name)
    placeholder = I18n.t('view.placeholder_search', search_cont: search_content_name)
    case search_content_name
    when setting_shared_column(val: :title)
      form.search_field :title_cont, placeholder: placeholder, id: 'increment-title-search'
    when setting_shared_column(val: :tag)
      form.search_field :tag_cont, placeholder: placeholder, id: 'increment-tag-search'
    end
  end
end
