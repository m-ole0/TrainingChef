class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipes, dependent: :destroy

# フォローした、されたの関係
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
# フォローフォロワー一覧用
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower

  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/, message: "は半角英数字で入力してください" }, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  has_one_attached :profile_image


end
