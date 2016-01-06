require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    create(:invoice_item)
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    create(:invoice_item)
    get :show, format: :json, id: InvoiceItem.first.id
    assert_response :success
    assert_equal InvoiceItem.first.id, json_response['id']
  end

  test 'api is showing you 1 record' do
      create(:invoice_item)
    get :show, format: :json, id: InvoiceItem.first.id

    assert_kind_of Hash, json_response
  end

  test 'you can find by a single attribute' do
    create(:invoice_item)
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
    create(:invoice_item)
    get :find, format: :json, id: InvoiceItem.first.id

    assert_response :success
    assert_equal InvoiceItem.first.id, json_response['id']
  end

  test '#findall returns more than one record' do
    create(:invoice_item)
    create(:invoice_item)
    get :find_all, format: :json, quantity: InvoiceItem.first.quantity
    assert_equal InvoiceItem.count, json_response.count
  end

  test "random responds to json" do
    get :random, format: :json
    assert_response :success
  end

  test '#invoice responds to json' do
    create(:invoice_item)
    get :invoice, format: :json, id: InvoiceItem.first.id
    assert_response :success
  end

  test '#item responds to json' do
    create(:invoice_item)
    get :item, format: :json, id: InvoiceItem.first.id
    assert_response :success
  end

  test '#invoice returns the invoice information tied to the invoice_item' do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)
    get :invoice, format: :json, id: invoice_item.id

    assert_equal invoice_item.invoice_id , json_response['id']
  end

  test '#item returns the item associated to the invoice_item' do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get :item, format: :json, id: invoice_item.id

    assert_equal invoice_item.item_id , json_response['id']
  end
end
