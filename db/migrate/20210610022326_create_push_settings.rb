class CreatePushSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :push_settings do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.integer :push_day, null: false
      t.string :push_time, null: false

      t.timestamps
    end
  end
end
