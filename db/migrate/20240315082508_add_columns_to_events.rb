class AddColumnsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :date, :datetime
    add_column :events, :meetup_id, :string
  end
end
