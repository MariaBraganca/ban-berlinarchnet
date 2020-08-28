class AddUserToChatroom < ActiveRecord::Migration[6.0]
  def change
    add_reference :chatrooms, :user, null: false, foreign_key: true
  end
end
