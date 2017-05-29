class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :zone
      t.integer :test_score
      t.integer :school_id
      t.boolean :assigned, default: false
    end
  end
end
