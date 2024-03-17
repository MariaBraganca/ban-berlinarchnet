class ValidateEventLocationNotNull < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        validate_check_constraint :events, name: "events_location_null"

        change_column_null :events, :location, false
        remove_check_constraint :events, name: "events_location_null"
      end
      direction.down do
        add_check_constraint :events, "location IS NOT NULL", name: "events_location_null", validate: false
        change_column_null :events, :location, true
      end
    end
  end
end
