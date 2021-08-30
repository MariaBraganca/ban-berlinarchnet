class User < ApplicationRecord
  # associations
  has_many :experiences
  has_many :offices, through: :experiences
  has_many :rsvps
  has_many :events, through: :rsvps
  has_many :messages
  has_many :chatrooms_as_user_one, foreign_key: :user_one_id, class_name: :Chatroom
  has_many :chatrooms_as_user_two, foreign_key: :user_two_id, class_name: :Chatroom
  has_many :comments
  has_many :posts
  has_many :notifications, foreign_key: :recipient_id

  has_one_attached :photo
  has_many_attached :portfolio_photos

  # validations
  validates_presence_of :first_name, :last_name, :email, :encrypted_password


  # PgSearch
  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :first_name, :last_name ],
    using: {
      tsearch: { prefix: true }
    }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    [first_name.capitalize, last_name.capitalize].join(' ')
  end

  # def chatrooms
    # chatrooms_as_user_one + chatrooms_as_user_two
  # end

  # after_create :welcome_send
  # def welcome_send
  #   UserMailer.welcome_send(self).deliver
  # end
end
