class User < ApplicationRecord
  has_many :experiences
  has_many :offices, through: :experiences
  has_many :rsvps
  has_many :events, through: :rsvps
  has_many :messages
  has_many :chatrooms, through: :messages
  has_many :comments

  has_one_attached :photo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
