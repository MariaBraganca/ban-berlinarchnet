class AddOfficeLogoToOpenings < ActiveRecord::Migration[6.0]
  def change
    add_column :openings, :office_logo, :string
  end
end
