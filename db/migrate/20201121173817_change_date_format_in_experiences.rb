class ChangeDateFormatInExperiences < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      change_table :experiences do |t|
        dir.up   { t.change :start_date, :datetime }
        dir.down { t.change :start_date, :date }
      end
    end
    reversible do |dir|
      change_table :experiences do |t|
        dir.up   { t.change :end_date, :datetime }
        dir.down { t.change :end_date, :date }
      end
    end
  end
end
