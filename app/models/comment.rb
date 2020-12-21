class Comment < ApplicationRecord
  # associations
  belongs_to :post, optional: true
  belongs_to :event, optional: true
  belongs_to :office, optional: true
  belongs_to :user

  # validations
  validates :date, presence: true
  validates :content, presence: true
end
