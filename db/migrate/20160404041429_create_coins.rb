class CreateCoins < ActiveRecord::Migration
  def change
    create_table :coins do |t|
      t.string :serial_number

      t.timestamps null: false
    end
  end
end
