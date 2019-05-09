require 'date'

class ApplicationController < ActionController::Base
  before_action :set_side_contents_disp

  def set_side_contents_disp
    @is_disp_side = true
  end

  def model_save_and_redirect(redirect_url, render_url, model)
    if model.save
      redirect_to(redirect_url)
    else
      render(render_url)
    end
  end

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
