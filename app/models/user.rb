class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :user_id, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 10..128
  has_many :comments, dependent: :destroy
  has_many :categorys, dependent: :destroy
  has_many :posts, dependent: :destroy
end
