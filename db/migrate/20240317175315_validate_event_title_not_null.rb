class ValidateEventTitleNotNull < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        validate_check_constraint :events, name: "events_title_null"

        change_column_null :events, :title, false
        remove_check_constraint :events, name: "events_title_null"
      end
      direction.down do
        add_check_constraint :events, "title IS NOT NULL", name: "events_title_null", validate: false
        change_column_null :events, :title, true
      end
    end
  end
end
