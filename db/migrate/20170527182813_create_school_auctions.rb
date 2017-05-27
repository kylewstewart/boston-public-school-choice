class CreateSchoolAuctions < ActiveRecord::Migration[5.1]
  def change
    create_table :school_auctions do |t|
      t.integer :school_id
      t.integer :auction_id

      t.timestamps
    end
  end
end
