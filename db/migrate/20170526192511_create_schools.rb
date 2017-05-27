class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :availability
      t.integer :zone

      t.timestamps
    end
  end
end
