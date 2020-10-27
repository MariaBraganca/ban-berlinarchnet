class ChangeDateFromEvents < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :events do |t|
        dir.up   { t.rename :date, :start_date }
        dir.down { t.rename :date, :date }
      end
    end
  end
end
