class AddOnlineLinkToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :online_link, :string
  end
end
