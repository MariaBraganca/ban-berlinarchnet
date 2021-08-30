class Message < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :chatroom

  # validations
  validates_presence_of :content
end
