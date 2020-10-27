class ChangeEventsDate < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :events do |t|
        dir.up   { t.change :date, :datetime }
        dir.down { t.change :date, :date }
      end
    end
  end
end
