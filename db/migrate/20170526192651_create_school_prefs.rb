class CreateSchoolPrefs < ActiveRecord::Migration[5.1]
  def change
    create_table :school_prefs do |t|
      t.integer :school_id
      t.integer :student_id
      t.integer :rank

      t.timestamps
    end
  end
end
