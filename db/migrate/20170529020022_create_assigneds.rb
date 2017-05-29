class CreateAssigneds < ActiveRecord::Migration[5.1]
  def change
    create_table :assigneds do |t|
      t.integer :student_id
      t.integer :school_id

    end
  end
end
