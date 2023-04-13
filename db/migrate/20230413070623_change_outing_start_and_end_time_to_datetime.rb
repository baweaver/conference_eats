class ChangeOutingStartAndEndTimeToDatetime < ActiveRecord::Migration[7.0]
  def change
    change_column :outings, :start_time, :datetime
    change_column :outings, :end_time, :datetime
  end
end
