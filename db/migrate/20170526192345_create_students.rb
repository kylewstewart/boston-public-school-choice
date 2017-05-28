class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :assigned_school
      t.integer :zone
      t.integer :test_score
    end
  end
end
