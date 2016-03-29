class CoinEntriesController < ApplicationController
  before_action :set_coin_entry, only: [:show, :edit, :update, :destroy]

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
    @coin_entry = CoinEntry.new(coin_entry_params)

    respond_to do |format|
      if @coin_entry.save
        format.html { redirect_to @coin_entry, notice: 'Coin entry was successfully created.' }
        format.json { render :show, status: :created, location: @coin_entry }
      else
        format.html { render :new }
        format.json { render json: @coin_entry.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coin_entry
      @coin_entry = CoinEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coin_entry_params
      params.require(:coin_entry).permit(:city, :region, :country, :serial_number)
    end
end