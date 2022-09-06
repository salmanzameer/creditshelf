class AddDepartmentIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :department_id, :integer
  end
end
