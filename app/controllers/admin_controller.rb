require 'geokit'

class AdminController < ApplicationController

  include Geokit::Geocoders

  def main
  	@coin_entry = CoinEntry.new
  	@coin_entry.country = "USA"
  end
end