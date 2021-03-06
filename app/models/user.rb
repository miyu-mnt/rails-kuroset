class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  
  validates :name, presence: true, length: {maximum: 15}
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
  validates :password, presence: true, length: {in: 8..32}, format: {with: VALID_PASSWORD_REGEX}
  validates :user_bio, length: {maximum: 100}
  
  has_secure_password
  
  has_many :topics, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_topics, through: :favorites, source: 'topic', dependent: :destroy
  has_many :comments, dependent: :destroy
  
  mount_uploader :user_image, ImageUploader
end
