class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :zone
      t.integer :test_score
      t.integer :assigned_id
      t.integer :accepted_id

    end
  end
end
