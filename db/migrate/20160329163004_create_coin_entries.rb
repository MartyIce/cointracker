class CreateCoinEntries < ActiveRecord::Migration
  def change
    create_table :coin_entries do |t|
      t.string :city
      t.string :region
      t.string :country
      t.string :serial_number

      t.timestamps null: false
    end
  end
end
