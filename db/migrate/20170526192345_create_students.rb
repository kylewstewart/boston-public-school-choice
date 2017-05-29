class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :zone
      t.integer :test_score

      t.integer :accepted
      t.integer :rejected
      t.integer :assigned
    end
  end
end
