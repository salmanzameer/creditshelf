class AddIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :groups, :created_at
    add_index :lunch_groups, :created_at
    add_index :lunch_groups, :group_id
    add_index :lunch_groups, :user_id
  end
end
