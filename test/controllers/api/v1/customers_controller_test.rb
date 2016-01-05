require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "api serves up the index " do
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    get :show, format: :json, id: 1
    assert_response :success
  end

  test 'you can find by a single attribute' do
    get :find, format: :json, first_name: 'Joey'
    assert_response :success

    get :find, format: :json, last_name: 'Ondricka'
    assert_response :success
  end

  test 'case does not matter with a single attribute' do
    get :find, format: :json, first_name: 'JOEY'
    assert_response :success

    get :find, format: :json, first_name: 'joey'
    assert_response :success
  end

  test ' you can find a customer by id' do
    get :find, format: :json, id: 1
    assert_response :success
  end
end
