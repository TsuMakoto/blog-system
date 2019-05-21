module CategoryClassify
  extend ActiveSupport::Concern
  # カテゴリーを階層分けするメソッド
  # ==== Args
  # parent_categorys :: 親カテゴリのリスト
  # ==== Return
  # 階層分けされたカテゴリのリスト
  def classify_category(parent_categorys)
    categorys = []
    stack = []
    stack.concat(parent_categorys)
    level = 1
    child_count = 1
    until stack.empty?
      parent = stack.pop
      child_count -= 1
      category = { id: parent.id, name: parent.name, level: level }
      categorys.push(category)
      children = parent.children
      if children.empty? && child_count == 0
        level -= 1
      elsif !children.empty?
        level += 1
        stack.concat(children)
        child_count = children.count
      end
    end
    categorys
  end
end
