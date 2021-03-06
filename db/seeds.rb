# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'

  # MySQL and PostgreSQL
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")

  # SQLite
  # ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
end

def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

1.upto(250) do |i|
   Coin.create(:serial_number => i.to_s.rjust(3, '0'))
end

cities = ["Decatur", "Los Angeles", "New York", "Pittsburgh", "Minneapolis", "Miami", "Denver", "Portland", "Boise", "Austin",
"Phoenix", "Cheyenne", "Kansas City", "Nashville", "Atlanta"]
states = ["IL", "CA", "NY", "PA", "MN", "FL", "CO", "OR", "ID", "TX",
"AZ", "WY", "KS", "TN", "GA"]

Coin.all.each do |c|	
	1.upto(rand(10)) do |i|
		arrayInd = rand(cities.length)
	   CoinEntry.create(
      :serial_number => c.serial_number, 
      :city => cities[arrayInd], 
      :state => states[arrayInd], 
      :country => 'USA',
      :created_at => time_rand(Time.local(2016, 4, 1)),
      :description => "Well this one time I did blah blah blah, and then blah blah blah, and then blah blah blah, and then blah blah blah, and then blah blah blah!"
    )
	end
end



