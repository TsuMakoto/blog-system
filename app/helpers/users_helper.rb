module UsersHelper
  def limited_model(model)
    model.order(created_at: :desc).limit(5)
  end
end
