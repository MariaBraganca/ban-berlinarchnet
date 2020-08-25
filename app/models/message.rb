class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates :date_time, presence: true
  validates :content, presence: true
end
