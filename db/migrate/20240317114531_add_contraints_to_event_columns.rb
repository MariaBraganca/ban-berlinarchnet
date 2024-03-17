class AddContraintsToEventColumns < ActiveRecord::Migration[7.0]
  def change
    add_check_constraint :events, "title IS NOT NULL", name: "events_title_null", validate: false
    add_check_constraint :events, "date IS NOT NULL", name: "events_date_null", validate: false
    add_check_constraint :events, "location IS NOT NULL", name: "events_location_null", validate: false
    add_check_constraint :events, "meetup_id IS NOT NULL", name: "events_meetup_id_null", validate: false
  end
end
