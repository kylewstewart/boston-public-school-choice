class CreateRejecteds < ActiveRecord::Migration[5.1]
  def change
    create_table :rejecteds do |t|
      t.integer :student_id
      t.integer :school_id

    end
  end
end
