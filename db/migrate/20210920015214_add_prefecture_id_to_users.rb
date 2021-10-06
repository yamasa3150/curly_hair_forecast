class AddPrefectureIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :prefecture_id, :integer
  end
end
