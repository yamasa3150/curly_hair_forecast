class RemovePushDayFromPushSettings < ActiveRecord::Migration[6.0]
  def change
    remove_column :push_settings, :push_day, :integer
  end
end
