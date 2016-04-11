class CoinEntry < ActiveRecord::Base
	validates :city, :presence => true
	validates :state, :presence => true
end
