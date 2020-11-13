class AddDetailsToOpenings < ActiveRecord::Migration[6.0]
  def change
    add_column :openings, :job_site, :string
    add_column :openings, :job_url, :string
    add_column :openings, :office_name, :string
    add_column :openings, :office_url, :string
  end
end
