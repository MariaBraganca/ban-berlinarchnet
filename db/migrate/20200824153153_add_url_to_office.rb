class AddUrlToOffice < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :url, :string
  end
end
