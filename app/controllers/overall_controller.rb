class OverallController < ApplicationController
  def category
    @parent_categorys = Category.where(user_id: current_user.id, parent_category_id: 0)
    @categorys = classify_category(@parent_categorys)
  end

  def new_cate
    @category = Category.new(
      name: params[:new_categrory],
      parent_category_id: params[:parent].to_i
    )
    model_save_and_redirect('/overall/category', '/overall/category', @category)
  end
end
