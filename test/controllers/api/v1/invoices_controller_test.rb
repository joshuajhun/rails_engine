require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "api serves up the index " do
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    get :show, format: :json, id: Invoice.first.id
    assert_response :success
    assert_kind_of Hash, json_response
  end

  test 'you can find by a single attribute' do
    get :find, format: :json, customer_id: Invoice.first.customer_id

    assert_response :success
    assert_equal Invoice.first.customer_id, json_response['customer_id']

    get :find, format: :json, status: Invoice.first.status

    assert_response :success
    assert_equal Invoice.first.status, json_response['status']

  end

  test 'case does not matter with a single attribute' do
    get :find, format: :json, status: Invoice.first.status.upcase

    assert_response :success
    assert_equal Invoice.first.status, json_response['status']
  end

  test ' you can find a invoice by id' do
    get :find, format: :json, id: Invoice.first.id
    assert_response :success
    assert_equal Invoice.first.id, json_response['id']
  end

  test '#find returns one record ' do
    get :find, format: :json, id: Invoice.first.id
    assert_kind_of Hash, json_response
  end

  test 'find_all returns more than one record' do
    get :find_all, format: :json, status: Invoice.first.status
    assert_equal Invoice.count, json_response.count
  end
end
