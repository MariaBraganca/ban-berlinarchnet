class RemoveDescriptionFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :description, :text
  end
end
