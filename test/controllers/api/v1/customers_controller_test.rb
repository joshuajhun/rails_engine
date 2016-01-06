require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase

  test "api serves up the index " do
    create(:customer)
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    create(:customer)
    get :show, format: :json, id: Customer.first.id
    assert_response :success

    assert_equal Customer.first.id , json_response['id']
  end

  test '#show returns 1 record' do
    create(:customer)
    get :show, format: :json, id: Customer.first.id
    assert_response :success

    assert_kind_of Hash, json_response
  end

  test 'you can find by a single attribute' do
    create(:customer)
    get :find, format: :json, first_name: Customer.first.first_name
    assert_response :success
    assert_equal Customer.first.first_name, json_response['first_name']

    get :find, format: :json, last_name: Customer.first.last_name
    assert_response :success
    assert_equal Customer.first.last_name, json_response['last_name']
  end

  test 'case does not matter with a single attribute' do
    create(:customer)
    get :find, format: :json, first_name: Customer.first.first_name.upcase
    assert_response :success
    assert_equal Customer.first.first_name, json_response['first_name']

    get :find, format: :json, last_name: Customer.first.last_name.upcase
    assert_response :success
    assert_equal Customer.first.last_name, json_response['last_name']
  end

  test ' you can find a customer by id' do
    create(:customer)
    get :find, format: :json, id: Customer.first.id
    assert_response :success
    assert_equal Customer.first.id, json_response['id']
  end

  test 'find is returning 1 record' do
    create(:customer)
    get :find, format: :json, first_name: Customer.first.first_name
    assert_kind_of Hash, json_response

    get :find, format: :json, last_name:  Customer.first.last_name
    assert_kind_of Hash, json_response
  end

  test '#findall returns more than one record' do
    create(:customer)
    get :find_all, format: :json, first_name: Customer.first.first_name
    assert_response :success
    assert_equal Customer.count, json_response.count
  end

  test "random responds to json" do
    get :random, format: :json
    assert_response :success
  end

  test '#invoices responds to json' do
    create(:customer)
    get :invoices, format: :json, id: Customer.first.id
    assert_response :success
  end

  test '#transactions responds to json' do
    create(:customer)
    get :transactions, format: :json, id: Customer.first.id
    assert_response :success
  end


end
