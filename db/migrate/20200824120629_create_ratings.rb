class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.float :culture
      t.float :salary
      t.float :architecture
      t.references :office, null: false, foreign_key: true

      t.timestamps
    end
  end
end
