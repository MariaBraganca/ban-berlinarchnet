class CreateOfficeRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :office_ratings do |t|
      t.references :office, null: false, foreign_key: true
      t.references :rating, null: false, foreign_key: true

      t.timestamps
    end
  end
end
