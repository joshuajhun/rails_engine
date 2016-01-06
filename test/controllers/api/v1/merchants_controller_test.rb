require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    get :show, format: :json, id: Merchant.first.id
    assert_response :success
    assert_equal Merchant.first.id, json_response['id']
  end

  test '#show returns one item' do
    get :show, format: :json, id: Merchant.first.id

    assert_kind_of Hash, json_response
  end

  test 'you can find by a single attribute' do
    get :find, format: :json, name: Merchant.first.name
    assert_response :success
    assert_equal Merchant.first.name, json_response['name']
  end

  test 'case does not matter with a single attribute' do
    get :find, format: :json, name: Merchant.first.name.upcase
    assert_response :success
    assert_equal Merchant.first.name, json_response['name']

    get :find, format: :json, name: Merchant.first.name.downcase
    assert_response :success
    assert_equal Merchant.first.name, json_response['name']
  end

  test ' you can find a merchant by id' do
    get :find, format: :json, id: Merchant.first.id
    assert_response :success
    assert_equal Merchant.first.id, json_response['id']
  end

  test '#find returns to you a single record' do
    get :find, format: :json, name: Merchant.first.name
    assert_kind_of Hash, json_response
  end

  test '#find_all returns to you more than one record' do
    get :find_all, format: :json, name: Merchant.first.name
    assert_equal Merchant.count, json_response.count
  end 
end
