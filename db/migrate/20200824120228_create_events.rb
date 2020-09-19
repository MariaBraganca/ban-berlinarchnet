class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :location
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
