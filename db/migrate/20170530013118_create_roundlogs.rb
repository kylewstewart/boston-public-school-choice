class CreateRoundlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :roundlogs do |t|
      t.integer :auction_id
      t.integer :round
      t.integer :school_id
      t.integer :applicants
      t.integer :accepted
      t.integer :rejected
    end
  end
end
