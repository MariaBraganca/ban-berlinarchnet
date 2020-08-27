class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.datetime :date
      t.text :content
      t.references :post, null: true, foreign_key: true
      t.references :event,null: true, foreign_key: true
      t.references :office,null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
