class Topic < ApplicationRecord
  validates :user_id, presence: true
  validates :image, presence: true
  validates :description, length: {maximum: 500}
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: 'user', dependent: :destroy
  has_many :comments, dependent: :destroy
  
  mount_uploader :image, ImageUploader
end
