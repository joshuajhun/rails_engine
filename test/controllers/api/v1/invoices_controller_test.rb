require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "api serves up the index " do
    create(:invoice)
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    create(:invoice)
    get :show, format: :json, id: Invoice.first.id
    assert_response :success
    assert_kind_of Hash, json_response
  end

  test 'you can find by a single attribute' do
    create(:invoice)
    get :find, format: :json, customer_id: Invoice.first.customer_id

    assert_response :success
    assert_equal Invoice.first.customer_id, json_response['customer_id']

    get :find, format: :json, status: Invoice.first.status

    assert_response :success
    assert_equal Invoice.first.status, json_response['status']

  end

  test 'case does not matter with a single attribute' do
    create(:invoice)
    get :find, format: :json, status: Invoice.first.status.upcase

    assert_response :success
    assert_equal Invoice.first.status, json_response['status']
  end

  test ' you can find a invoice by id' do
    create(:invoice)
    get :find, format: :json, id: Invoice.first.id
    assert_response :success
    assert_equal Invoice.first.id, json_response['id']
  end

  test '#find returns one record ' do
    create(:invoice)
    get :find, format: :json, id: Invoice.first.id
    assert_kind_of Hash, json_response
  end

  test 'find_all returns more than one record' do
    create(:invoice)
    get :find_all, format: :json, status: Invoice.first.status
    assert_equal Invoice.count, json_response.count
  end

  test "random responds to json" do
    get :random, format: :json
    assert_response :success
  end

  test '#transactions responds to json' do
    create(:invoice)
    get :transactions, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test '#invoice_items responds to json' do
    create(:invoice)
    get :invoice_items, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test '#items responds to json' do
    create(:invoice)
    get :items, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test '#customer responds to json' do
    create(:invoice)
    get :customer, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test '#merchant responds to json' do
    create(:invoice)
    get :merchant, format: :json, id: Invoice.first.id
    assert_response :success
  end

end
