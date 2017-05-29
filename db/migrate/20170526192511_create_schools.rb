class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string  :name
      t.integer :zone
      t.integer :capacity
      t.integer :availability

    end
  end
end
