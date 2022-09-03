class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.text :name
      t.timestamps
    end
  end
end
