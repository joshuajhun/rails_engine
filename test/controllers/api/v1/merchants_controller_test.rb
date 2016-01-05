require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    get :show, format: :json, id: 1
    assert_response :success
  end 
end
