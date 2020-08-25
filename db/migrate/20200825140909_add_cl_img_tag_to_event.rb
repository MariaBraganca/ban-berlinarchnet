class AddClImgTagToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :cl_img_tag, :string
  end
end
