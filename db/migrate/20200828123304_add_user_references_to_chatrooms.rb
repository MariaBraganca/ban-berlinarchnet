class AddUserReferencesToChatrooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :chatrooms, :user_one, foreign_key: { to_table: :users }
    add_reference :chatrooms, :user_two, foreign_key: { to_table: :users }
  end
end
