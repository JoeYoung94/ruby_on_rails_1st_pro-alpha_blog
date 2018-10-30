class Article < ApplicationRecord
  belongs_to :user
  # add validations
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}

  #add validations for user & articles
  validates :user_id, presence: true
end
