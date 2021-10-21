class RemovePrefectureIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :prefecture_id, :integer
  end
end
