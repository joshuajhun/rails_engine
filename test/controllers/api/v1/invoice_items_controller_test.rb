require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    create(:invoice_item)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns and array of records' do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of items' do
    get :index, format: :json

    assert_equal InvoiceItem.count, json_response.count
  end

  test '#index have correct properties' do
  get :index, format: :json

    json_response.each do |invoice_item|
      assert invoice_item["item_id"]
      assert invoice_item['invoice_id']
      assert invoice_item['quantity']
      assert invoice_item['unit_price']
    end
  end


  test '#show returns correct invoice item' do
    create(:invoice_item)
    get :show, format: :json, id: InvoiceItem.first.id
    assert_response :success
    assert_equal InvoiceItem.first.id, json_response['id']
  end

  test '#show returns 1 invoice item' do
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
