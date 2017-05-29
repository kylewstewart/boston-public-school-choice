class CreateTableAuctions < ActiveRecord::Migration[5.1]
  def change
    create_table :auctions do |t|
      t.string :results
    end
  end
end
