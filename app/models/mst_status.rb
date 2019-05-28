class MstStatus < ApplicationRecord
  has_many :posts, dependent: :nullify
end
