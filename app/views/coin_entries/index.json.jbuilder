json.array!(@coin_entries) do |coin_entry|
  json.extract! coin_entry, :id, :city, :state, :country, :serial_number
  json.url coin_entry_url(coin_entry, format: :json)
end
