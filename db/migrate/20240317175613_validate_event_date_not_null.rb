class ValidateEventDateNotNull < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        validate_check_constraint :events, name: "events_date_null"

        change_column_null :events, :date, false
        remove_check_constraint :events, name: "events_date_null"
      end
      direction.down do
        add_check_constraint :events, "date IS NOT NULL", name: "events_date_null", validate: false
        change_column_null :events, :date, true
      end
    end
  end
end
