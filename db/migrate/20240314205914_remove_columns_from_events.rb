class RemoveColumnsFromEvents < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      remove_column :events, :cl_img_tag, :string
      remove_column :events, :latitude, :float
      remove_column :events, :longitude, :float
      remove_column :events, :venue, :string
      remove_column :events, :online, :boolean
      remove_column :events, :online_link, :string
      remove_column :events, :format, :string
      remove_column :events, :end_date, :datetime
      remove_column :events, :start_date, :datetime

      remove_foreign_key :events, :users
      remove_column :events, :user_id, :bigint
    end
  end
end
