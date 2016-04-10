require 'test_helper'

class CoinEntriesControllerTest < ActionController::TestCase
  setup do
    @coin_entry = coin_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coin_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coin_entry" do
    assert_difference('CoinEntry.count') do
      post :create, coin_entry: { city: @coin_entry.city, country: @coin_entry.country, state: @coin_entry.state, serial_number: @coin_entry.serial_number }
    end

    assert_redirected_to coin_entry_path(assigns(:coin_entry))
  end

  test "should show coin_entry" do
    get :show, id: @coin_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coin_entry
    assert_response :success
  end

  test "should update coin_entry" do
    patch :update, id: @coin_entry, coin_entry: { city: @coin_entry.city, country: @coin_entry.country, state: @coin_entry.state, serial_number: @coin_entry.serial_number }
    assert_redirected_to coin_entry_path(assigns(:coin_entry))
  end

  test "should destroy coin_entry" do
    assert_difference('CoinEntry.count', -1) do
      delete :destroy, id: @coin_entry
    end

    assert_redirected_to coin_entries_path
  end
end
