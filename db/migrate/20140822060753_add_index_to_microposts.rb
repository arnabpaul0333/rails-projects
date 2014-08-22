class AddIndexToMicroposts < ActiveRecord::Migration
  def change
  end
  add_index :microposts, [:user_id, :created_at]
end
