class Post < ApplicationRecord
  belongs_to :user
  belongs_to :mst_status
  belongs_to :category
end
