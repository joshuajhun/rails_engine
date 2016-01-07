require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase

  test "api serves up the index " do
    create(:customer)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns and array of records' do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of items' do
    get :index, format: :json

    assert_equal Customer.count, json_response.count
  end

  test '#index have correct properties' do
  get :index, format: :json

    json_response.each do |customer|
      assert customer["first_name"]
      assert customer['last_name']
    end
  end

  test 'api allows you to view the show of a specific customer' do
    create(:customer)
    get :show, format: :json, id: Customer.first.id
    assert_response :success

    assert_equal Customer.first.id , json_response['id']
  end

  test '#show returns 1 customer' do
    create(:customer)
    get :show, format: :json, id: Customer.first.id
    assert_response :success

    assert_kind_of Hash, json_response
  end

  test '#show returns the correct customer' do
    create(:customer)
    get :show, format: :json, id: Customer.first.id
    assert_response :success

    assert_equal Customer.first.id, json_response['id']
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

  test '#invoice returns a specific customer data' do
    customer = create(:customer)
    create(:invoice, customer: customer)
    create(:invoice, customer: customer)
    get :invoices, format: :json, id: customer.id

    assert_equal customer.id, json_response.first['customer_id']
    assert_equal 2, json_response.count
  end

  test '#transactions return speicific customer data' do
    customer =  create(:customer)
    invoice  =  create(:invoice, customer: customer)
    create(:transaction, invoice: invoice)
    create(:transaction, invoice: invoice)
    get :transactions, format: :json, id: customer.id

    assert_equal invoice.id, json_response.first['invoice_id']
    assert_equal customer.id,  Invoice.find(json_response.first['invoice_id']).customer_id
    assert_equal 2, json_response.count
  end

  test '#favorite_merchant' do
    customer     = create(:customer)
    merchant1    = create(:merchant, name: 'aaron')
    invoice      = create(:invoice, customer: customer, merchant: merchant1)
    invoice2     = create(:invoice, customer: customer, merchant: merchant1)
    invoice3     = create(:invoice, customer: customer, merchant: merchant1)
    transaction1 = create(:transaction, invoice: invoice)
    transaction2 = create(:transaction, invoice: invoice2)
    transaction3 = create(:transaction, invoice: invoice3)


    merchant2    = create(:merchant, name: 'steve')
    invoice4     = create(:invoice, customer: customer, merchant: merchant2)
    invoice5     = create(:invoice, customer: customer, merchant: merchant2)
    transaction4 = create(:transaction, invoice: invoice4)
    transaction5 = create(:transaction, invoice: invoice5)

    get :favorite_merchant, format: :json, id: customer.id

    assert_equal merchant1.id, json_response['id']
  end

end
