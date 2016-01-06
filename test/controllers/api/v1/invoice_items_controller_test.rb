require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    get :show, format: :json, id: InvoiceItem.first.id
    assert_response :success
    assert_equal Invoice.first.id, json_response['id']
  end

  test 'api is showing you 1 record' do
    get :show, format: :json, id: InvoiceItem.first.id

    assert_kind_of Hash, json_response
  end

  test 'you can find by a single attribute' do
    get :find, format: :json, id: InvoiceItem.first.id
    assert_response :success

    assert_equal InvoiceItem.first.id, json_response['id']

    get :find, format: :json, item_id: InvoiceItem.first.item_id

    assert_equal InvoiceItem.first.item_id, json_response['item_id']
    assert_response :success

    get :find, format: :json, invoice_id: InvoiceItem.first.invoice_id
    assert_response :success
    assert_equal InvoiceItem.first.invoice_id, json_response['invoice_id']
  end

  test ' you can find a invoice items by id' do
    get :find, format: :json, id: InvoiceItem.first.id

    assert_response :success
    assert_equal InvoiceItem.first.id, json_response['id']
  end

  test '#findall returns more than one record' do
    get :find_all, format: :json, quantity: InvoiceItem.first.quantity
    assert_equal InvoiceItem.count, json_response.count
  end
end
