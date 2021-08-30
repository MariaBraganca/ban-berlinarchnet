class Post < ApplicationRecord
  # associations
  belongs_to :user
  has_many :comments, dependent: :nullify

  # validations
  validates_presence_of :date, :title, :content

  # named scopes
  scope :recent, lambda { where("date > ?", 1.month.ago) }
  scope :old, lambda { where("date < ?", 1.month.ago) }
  scope :sorted, lambda { order(date: :desc) }
  scope :by_user, lambda { |user_id|
    where("user_id = ?", user_id)
  }

  # active storage
  has_one_attached :photo

  # action text
  has_rich_text :content

  # tags
  acts_as_taggable_on :tags
end
