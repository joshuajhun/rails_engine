require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "api serves up the index " do
    create(:invoice)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns and array of records' do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of items' do
    get :index, format: :json

    assert_equal Invoice.count, json_response.count
  end

  test '#index have correct properties' do
  get :index, format: :json

    json_response.each do |invoice|
      assert invoice["customer_id"]
      assert invoice['merchant_id']
      assert invoice['status']
    end
  end

  test '#show returns the correct invoice' do
    create(:invoice)
    get :show, format: :json, id: Invoice.first.id
    assert_response :success

    assert_equal Invoice.first.id, json_response['id']
  end

  test '#show returns 1  invoice' do
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

  test '#transactions relationship returns transactions linked' do
    invoice  = create(:invoice)
    transaction = create(:transaction, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)
    get :transactions, format: :json, id: invoice.id

    assert_equal invoice.id, json_response.first['invoice_id']
    assert_equal 2, json_response.count
  end

  test '#invoice_items responds to json' do
    create(:invoice)
    get :invoice_items, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test '#invoice_items returns the correct items linked' do
    invoice = create(:invoice)
    create(:invoice_item, invoice: invoice)
    create(:invoice_item, invoice: invoice)
    get :invoice_items, format: :json, id: invoice.id

    assert_equal invoice.id, json_response.first['invoice_id']
    assert_equal 2, json_response.count
  end

  test '#items responds to json' do
    create(:invoice)
    get :items, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test '#items returns the correct items related to 'do
   invoice = create(:invoice)
   item    = create(:item)
   invoice_item = create(:invoice_item, item: item, invoice: invoice)
   get :items, format: :json, id: invoice.id

   assert_equal invoice.invoice_items.first['item_id'], json_response.first['id']
 end

  test '#customer responds to json' do
    create(:invoice)
    get :customer, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test '#item returns records associtated with invoice' do
    customer = create(:customer)
    invoice  = create(:invoice, customer: customer)
    get :customer, format: :json, id: invoice.id

    assert_equal invoice.customer_id , json_response['id']
  end

  test '#merchant responds to json' do
    create(:invoice)
    get :merchant, format: :json, id: Invoice.first.id
    assert_response :success
  end

  test '#merchant returns records associated to invoice' do
    merchant = create(:merchant)
    invoice  = create(:invoice, merchant: merchant)
    get :merchant, format: :json, id: invoice.id

    assert_equal invoice.merchant_id, json_response['id']
  end
end
