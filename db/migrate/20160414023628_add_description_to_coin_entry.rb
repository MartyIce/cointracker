class AddDescriptionToCoinEntry < ActiveRecord::Migration
  def change
  	add_column :coin_entries, :description, :string
  end
end
