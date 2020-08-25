class AddClImgTagToOffice < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :cl_img_tag, :string
  end
end
