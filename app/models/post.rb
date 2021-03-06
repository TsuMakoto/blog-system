class Post < ApplicationRecord
  # タグの有効化
  acts_as_taggable

  belongs_to :user
  belongs_to :mst_status, optional: true
  belongs_to :category, optional: true

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true
end
