class AddFormatToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :format, :string
  end
end
