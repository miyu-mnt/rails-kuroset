class Comment < ApplicationRecord
  validates :content, presence: true, length: {maximum: 250}
  
  belongs_to :user
  belongs_to :topic
end
