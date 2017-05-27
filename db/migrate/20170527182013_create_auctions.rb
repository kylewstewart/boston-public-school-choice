class CreateAuctions < ActiveRecord::Migration[5.1]
  def change
    create_table :auctions do |t|
      t.string :method
      t.string :rounds
      t.string :match

      t.timestamps
    end
  end
end
