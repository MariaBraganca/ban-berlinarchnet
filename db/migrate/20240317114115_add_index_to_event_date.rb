class AddIndexToEventDate < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :events, :date, algorithm: :concurrently
  end
end
