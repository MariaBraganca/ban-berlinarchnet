class ValidateEventMeetupIdNotNull < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        validate_check_constraint :events, name: "events_meetup_id_null"

        change_column_null :events, :meetup_id, false
        remove_check_constraint :events, name: "events_meetup_id_null"
      end
      direction.down do
        add_check_constraint :events, "meetup_id IS NOT NULL", name: "events_meetup_id_null", validate: false
        change_column_null :events, :meetup_id, true
      end
    end
  end
end
