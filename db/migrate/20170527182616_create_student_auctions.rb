class CreateStudentAuctions < ActiveRecord::Migration[5.1]
  def change
    create_table :student_auctions do |t|
      t.integer :student_id
      t.integer :auction_id

      t.timestamps
    end
  end
end
