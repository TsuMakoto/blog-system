class Post < ApplicationRecord
  belongs_to :user
  belongs_to :mst_status
  belongs_to :category

  has_many :comments, dependent: :destroy
end
