class AddClImgTagToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :cl_img_tag, :string
  end
end
