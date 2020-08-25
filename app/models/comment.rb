class Comment < ApplicationRecord

  validates :post_id, numericality: true, allow_nil: true
  validates :event_id, numericality: true, allow_nil: true
  validates :office_id, numericality: true, allow_nil: true
  validates :date, presence: true
  validates :content, presence: true

  belongs_to :post, optional: true
  belongs_to :event, optional: true
  belongs_to :office, optional: true
  belongs_to :user
end
