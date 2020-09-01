class CreateOfficeProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :office_projects do |t|
      t.string :project_name
      t.string :project_img_url
      t.string :project_year
      t.string :project_typology
      t.references :office, null: false, foreign_key: true

      t.timestamps
    end
  end
end
