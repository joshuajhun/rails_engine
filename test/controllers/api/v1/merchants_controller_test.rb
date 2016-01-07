require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase

  test "api serves up the index " do
    create(:merchant)
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    create(:merchant)
    get :show, format: :json, id: Merchant.first.id
    assert_response :success
    assert_equal Merchant.first.id, json_response['id']
  end

  test '#show returns one item' do
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

  test 'case does not matter with a single attribute' do
    create(:merchant)
    get :find, format: :json, name: Merchant.first.name.upcase
    assert_response :success
    assert_equal Merchant.first.name, json_response['name']

    get :find, format: :json, name: Merchant.first.name.downcase
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

  test '#merchant returns records associated' do
    merchant = create(:merchant)
    invoice  = create(:invoice, merchant: merchant)
    invoice2 = create(:invoice, merchant: merchant)
    invoice3 = create(:invoice, merchant: merchant)
    transaction1  = create(:transaction, invoice: invoice)
    transaction2  = create(:transaction, invoice: invoice2)
    transaction3  = create(:transaction, invoice: invoice3)

    get :revenue, format: :jsoln, id: merchant.id
  end
end
