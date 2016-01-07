require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    create(:item)
    get :index, format: :json
    assert_response :success
  end

  test '#index returns and array of records' do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of items' do
    get :index, format: :json

    assert_equal Item.count, json_response.count
  end

  test '#index have correct properties' do
  get :index, format: :json

    json_response.each do |item|
      assert item["name"]
      assert item['description']
      assert item['merchant_id']
      assert item['unit_price']
    end
  end


  test '#show returns correct item' do
    create(:item)
    get :show, format: :json, id: Item.first.id

    assert_response :success
    assert_equal Item.first.id, json_response['id']
  end

  test '#show will return 1 item' do
    create(:item)
    get :show, format: :json, id: Item.first.id
    assert_kind_of Hash, json_response
  end


  test 'you can find by a single attribute' do
    create(:item)
    get :find, format: :json, name: Item.first.name
    assert_response :success
    assert_equal Item.first.name, json_response['name']

    get :find, format: :json, description: Item.first.description
    assert_equal Item.first.description, json_response['description']
  end

  test ' you can find a item by id' do
    create(:item)
    get :find, format: :json, id: Item.first.id
    assert_response :success
    assert_equal Item.first.id, json_response['id']
  end

  test '#find will only return one record' do
    create(:item)
    get :find, format: :json, id: Item.first.id

    assert_kind_of Hash, json_response
  end

  test '#find_all returns more than one record' do
    create(:item)
    get :find_all, format: :json, unit_price: Item.first.unit_price

    assert_equal Item.count, json_response.count
  end

  test "random responds to json" do
    get :random, format: :json
    assert_response :success
  end

  test '#invoice_items responds to json' do
    create(:item)
    get :invoice_items, format: :json, id: Item.first.id
    assert_response :success
  end

  test '#invoice_items returns records assoiciated with items' do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)
    create(:invoice_item, item: item)

    get :invoice_items, format: :json, id: item.id

    assert_equal item.id, json_response.first['item_id']
    assert_equal 2, json_response.count
  end

  test '#merchant responds to json' do
    create(:item)
    get :merchant, format: :json, id: Item.first.id
    assert_response :success
  end

  test '#merchant returns records associated with items' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    get :merchant, format: :json, id: item.id

    assert_equal item.merchant_id, json_response['id']
  end
end
