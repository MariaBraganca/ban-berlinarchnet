class AddVenueToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :venue, :string
  end
end
