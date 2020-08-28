class User < ApplicationRecord
  has_many :experiences
  has_many :offices, through: :experiences
  has_many :rsvps
  has_many :events, through: :rsvps
  has_many :messages
  has_many :chatrooms_as_user_one, source: :chatrooms, foreign_key: :user_one_id
  has_many :chatrooms_as_user_two, source: :chatrooms, foreign_key: :user_two_id
  has_many :comments
  has_many :posts

  has_one_attached :photo
  has_many_attached :portfolio_photos

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # def chatrooms
    # chatrooms_as_user_one + chatrooms_as_user_two
  # end
end
