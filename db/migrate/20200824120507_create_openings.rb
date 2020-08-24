class CreateOpenings < ActiveRecord::Migration[6.0]
  def change
    create_table :openings do |t|
      t.datetime :date
      t.string :job_position
      t.text :description
      t.references :office, null: false, foreign_key: true

      t.timestamps
    end
  end
end
