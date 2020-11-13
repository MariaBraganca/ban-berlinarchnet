class ChangeOfficeFromOpening < ActiveRecord::Migration[6.0]
  def up
    change_column_null :openings, :office_id, true
  end
  def down
    change_column_null :openings, :office_id, false
  end
end
