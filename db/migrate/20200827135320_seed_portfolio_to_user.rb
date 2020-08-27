class SeedPortfolioToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :seed_portfolio, :string
  end
end
