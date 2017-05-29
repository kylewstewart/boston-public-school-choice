class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string  :name
      t.integer :zone
      t.integer :capacity
      t.integer :availability

      t.integer  :accepted
      t.integer  :rejected
      t.integer  :assigned
    end
  end
end
