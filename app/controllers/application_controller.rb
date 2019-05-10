require 'date'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def model_save_and_redirect(redirect_url, render_url, model)
    if model.save
      redirect_to(redirect_url)
    else
      render(render_url)
    end
  end

  def model_destroy_and_redirect(redirect_url, render_url, model)
    if model.destroy
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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_id])
  end
end
