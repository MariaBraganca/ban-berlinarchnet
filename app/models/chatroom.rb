class Chatroom < ApplicationRecord
    has_many :messages, dependent: :destroy
    belongs_to :user_one, class_name: "User"
    belongs_to :user_two, class_name: "User"

  def users
    [user_one, user_two]
  end
end
