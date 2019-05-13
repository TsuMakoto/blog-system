class CategoryController < ApplicationController
  # GET /category/all
  # カテゴリの一覧を表示
  def all
    @parent_categorys = Category.where(user_id: current_user.id, parent_category_id: 0)
    @categorys = classify_category(@parent_categorys)
  end

  # POST /category/new
  # カテゴリの作成
  def new
    @category = Category.new(
      name: params[:new_categrory],
      parent_category_id: params[:parent].to_i,
      user_id: current_user.id
    )
    model_save_and_redirect('/category/new', '/category/new', @category)
  end
end
