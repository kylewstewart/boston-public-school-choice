class CreateStudentPrefs < ActiveRecord::Migration[5.1]
  def change
    create_table :student_prefs do |t|
      t.integer :school_id
      t.integer :student_id
      t.integer :rank
    end
  end
end
