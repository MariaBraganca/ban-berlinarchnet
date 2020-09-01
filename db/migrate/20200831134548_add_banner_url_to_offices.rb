class AddBannerUrlToOffices < ActiveRecord::Migration[6.0]
  def change
    add_column :offices, :banner_url, :string
  end
end
