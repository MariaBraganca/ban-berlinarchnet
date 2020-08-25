class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :event
  belongs_to :office
  belongs_to :user

  validates :date, presence: true
  validates :content, presence: true
end
