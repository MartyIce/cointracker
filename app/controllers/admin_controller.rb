require 'geokit'

class AdminController < ApplicationController

  include Geokit::Geocoders

  def main
  end
end