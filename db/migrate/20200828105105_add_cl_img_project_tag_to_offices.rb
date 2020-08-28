class AddClImgProjectTagToOffices < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :cl_img_project_tag, :string
  end
end
