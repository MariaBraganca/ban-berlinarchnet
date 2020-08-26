class Comment < ApplicationRecord
  validates :date, presence: true
  validates :content, presence: true

  belongs_to :post, optional: true
  belongs_to :event, optional: true
  belongs_to :office, optional: true
  belongs_to :user
end
