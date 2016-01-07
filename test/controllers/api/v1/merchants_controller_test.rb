require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase

  test "api serves up the index " do
    create(:merchant)
    get :index, format: :json

    assert_response :success
  end

  test '#index returns and array of records' do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of items' do
    get :index, format: :json

    assert_equal Merchant.count, json_response.count
  end

  test '#index have correct properties' do
  get :index, format: :json

    json_response.each do |merchant|
      assert merchant["name"]
    end
  end


  test '#show is returning correct merchant' do
    create(:merchant)
    get :show, format: :json, id: Merchant.first.id

    assert_response :success
    assert_equal Merchant.first.id, json_response['id']
  end

  test '#show returns one Merchant' do
    create(:merchant)
    get :show, format: :json, id: Merchant.first.id

    assert_kind_of Hash, json_response
  end

  test 'you can find by a single attribute' do
    create(:merchant)
    get :find, format: :json, name: Merchant.first.name

    assert_response :success
    assert_equal Merchant.first.name, json_response['name']
  end

  test ' you can find a merchant by id' do
    create(:merchant)
    get :find, format: :json, id: Merchant.first.id

    assert_response :success
    assert_equal Merchant.first.id, json_response['id']
  end

  test '#find returns to you a single record' do
    create(:merchant)
    create(:merchant)
    get :find, format: :json, name: Merchant.first.name

    assert_kind_of Hash, json_response
  end

  test '#find_all returns to you more than one record' do
    create(:merchant)
    create(:merchant)
    get :find_all, format: :json, name: Merchant.first.name

    assert_equal Merchant.count, json_response.count
  end

  test "random responds to json" do
    get :random, format: :json

    assert_response :success
  end

  test '#items responds to json' do
    create(:merchant)
    get :items, format: :json, id: Merchant.first.id

    assert_response :success
  end

  test '#items returns records associated to merchants' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    get :items, format: :json, id: merchant.id

    assert_equal merchant.id , json_response.first['merchant_id']
  end

  test '#invoices responds to json' do
    create(:merchant)
    get :invoices, format: :json, id: Merchant.first.id

    assert_response :success
  end

  test '#invoices returns records associated with mechants' do
    merchant = create(:merchant)
    invoice  = create(:invoice, merchant: merchant)
    get :invoices, format: :json, id: merchant.id

    assert_equal merchant.id, json_response.first['merchant_id']
  end

  test '#revenue returns records associated' do
    merchant = create(:merchant)
    invoice  = create(:invoice, merchant: merchant)
    invoice2 = create(:invoice, merchant: merchant)
    invoice3 = create(:invoice, merchant: merchant)

    invoice_item = create(:invoice_item, invoice: invoice)
    invoice_item2 = create(:invoice_item, invoice: invoice2)
    invoice_item3 = create(:invoice_item, invoice: invoice3)


    transaction1  = create(:transaction, invoice: invoice)
    transaction2  = create(:transaction, invoice: invoice2)
    transaction3  = create(:transaction, invoice: invoice3)


    merchant2 = create(:merchant, name: 'jhun')
    invoice4  = create(:invoice, merchant: merchant2)
    invoice_item4 = create(:invoice_item, invoice: invoice4)
    transaction4  = create(:transaction, invoice: invoice4)

    get :revenue, format: :json, id: merchant.id

    assert_equal "450.0", json_response['revenue']
  end

  test '#favorite_customer returns records associated with merchant' do
    merchant1 = create(:merchant)
    customer1 = create(:customer)
    invoice1  = create(:invoice, merchant: merchant1, customer: customer1)
    transaction1 = create(:transaction, invoice: invoice1)
    invoice2  = create(:invoice, merchant: merchant1, customer: customer1)
    transaction2 = create(:transaction, invoice: invoice2)

    customer2 = create(:customer, first_name: 'jhun')
    invoice3  = create(:invoice, merchant: merchant1, customer: customer2)
    transaction3 = create(:transaction, invoice: invoice3)


    get :favorite_customer, format: :json, id: merchant1.id

    assert_equal customer1.id, json_response['id']
  end

  test '#most items returns records associated with merchant' do
    

end
