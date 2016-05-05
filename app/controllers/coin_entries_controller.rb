require 'geokit'

class CoinEntriesController < ApplicationController

  include Geokit::Geocoders

  before_action :set_coin_entry, only: [:show, :edit, :update, :destroy], except: [:find_by_serial_number]
  skip_before_filter :verify_authenticity_token

  # GET /coin_entries
  # GET /coin_entries.json
  def index
    @coin_entries = CoinEntry.all
  end

  # GET /coin_entries/1
  # GET /coin_entries/1.json
  def show
  end

  # GET /coin_entries/new
  def new
    @coin_entry = CoinEntry.new
  end

  # GET /coin_entries/1/edit
  def edit
  end

  # POST /coin_entries
  # POST /coin_entries.json
  def create
    mod_params = coin_entry_params;
    states = {
      "alabama" => "AL",
      "alaska" => "AK",
      "arizona" => "AZ",
      "arkansas" => "AR",
      "california" => "CA",
      "colorado" => "CO",
      "connecticut" => "CT",
      "delaware" => "DE",
      "florida" => "FL",
      "georgia" => "GA",
      "hawaii" => "HI",
      "idaho" => "ID",
      "illinois" => "IL",
      "indiana" => "IN",
      "iowa" => "IA",
      "kansas" => "KS",
      "kentucky" => "KY",
      "louisiana" => "LA",
      "maine" => "ME",
      "maryland" => "MD",
      "massachusetts" => "MA",
      "michigan" => "MI",
      "minnesota" => "MN",
      "mississippi" => "MS",
      "missouri" => "MO",
      "montana" => "MT",
      "nebraska" => "NE",
      "nevada" => "NV",
      "new hampshire" => "NH",
      "new jersey" => "NJ",
      "new mexico" => "NM",
      "new york" => "NY",
      "north carolina" => "NC",
      "north dakota" => "ND",
      "ohio" => "OH",
      "oklahoma" => "OK",
      "oregon" => "OR",
      "pennsylvania" => "PA",
      "rhode island" => "RI",
      "south carolina" => "SC",
      "south dakota" => "SD",
      "tennessee" => "TN",
      "texas" => "TX",
      "utah" => "UT",
      "vermont" => "VT",
      "virginia" => "VA",
      "washington" => "WA",
      "west virginia" => "WV",
      "wisconsin" => "WI",
      "wyoming" => "WY"
    }

    mod_params[:state] = mod_params[:state].upcase
    if(!states.has_value?(mod_params[:state]))
      mod_params[:state] = states[mod_params[:state].downcase];
    end

    @coords = coords_for_city(mod_params);
    if(@coords && @coords.city && @coords.state_code && @coords.city.casecmp(mod_params[:city]) == 0 && @coords.state_code.casecmp(mod_params[:state]) == 0)
      mod_params[:city] = @coords.city;
      mod_params[:state] = @coords.state_code;

      begin
        mod_params["created_at"] = DateTime.strptime(mod_params["created_at"], "%m-%d-%Y" );
      rescue => ex
        mod_params["created_at"] = DateTime.now.to_date;
      end

      @coin_entry = CoinEntry.new(mod_params)

      respond_to do |format|
        if @coin_entry.save
          format.html { redirect_to '/' }
          format.json { render :show, status: :created, location: @coin_entry }
        else
          format.html { render :new }
          format.json { render json: @coin_entry.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render json: {'city': ['Invalid']}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coin_entries/1
  # PATCH/PUT /coin_entries/1.json
  def update
    respond_to do |format|
      if @coin_entry.update(coin_entry_params)
        format.html { redirect_to @coin_entry, notice: 'Coin entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @coin_entry }
      else
        format.html { render :edit }
        format.json { render json: @coin_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coin_entries/1
  # DELETE /coin_entries/1.json
  def destroy
    @coin_entry.destroy
    respond_to do |format|
      format.html { redirect_to coin_entries_url, notice: 'Coin entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def location_update
    retVal = []
    params["cities"].each do |k, c|
      retVal.push(coords_for_city(c))
    end
    render json: retVal
  end

  def coords_for_city(c) 
    key = c[:city] + "," + c[:state] + "," + c[:country];
    retVal = Rails.cache.fetch(key, expires_in: 12.hours) do
      MultiGeocoder.geocode(key)
    end

    if(!retVal.city)
      Rails.cache.delete(key);
      retVal = Rails.cache.fetch(key, expires_in: 12.hours) do
        MultiGeocoder.geocode(key)
      end
    end

    return retVal;
  end

  def find_by_serial_number
    render json: CoinEntry.where("serial_number=?", params[:id].to_i.to_s.rjust(3, '0')).sort_by{|c| c[:created_at]}
  end

  def find_last_for_each    
    byCity = CoinEntry.find_by_sql "SELECT serial_number, max(id) as id from coin_entries group by serial_number"
    ids = []
    byCity.each do |bc|
      if(bc.serial_number != nil && bc.serial_number != '711')
        ids.push(bc.id)
      end
    end
    coins = CoinEntry.find ids
    render json: coins.sort_by{|c| c[:serial_number]}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coin_entry
      @coin_entry = CoinEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coin_entry_params
      params.require(:coin_entry).permit(:city, :state, :country, :serial_number, :created_at, :description)
    end
end