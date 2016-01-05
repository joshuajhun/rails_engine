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

  test 'you can find by a single attribute' do
    get :find, format: :json, name: 'Schroeder-Jerde'
    assert_response :success
  end

  test 'case does not matter with a single attribute' do
    get :find, format: :json, name: 'schroeder-jerde'
    assert_response :success

    get :find, format: :json, name: 'SHROEDER-JERDE'
    assert_response :success
  end

  test ' you can find a merchant by id' do
    get :find, format: :json, id: 1
    assert_response :success
  end
end
