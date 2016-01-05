require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    get :show, format: :json, id: 1
    assert_response :success
  end

  test 'you can find by a single attribute' do
    get :find, format: :json, id: 1
    assert_response :success

    get :find, format: :json, item_id: 539
    assert_response :success

    get :find, format: :json, invoice_id: 539
    assert_response :success
  end

  test ' you can find a invoice items by id' do
    get :find, format: :json, id: 1
    assert_response :success
  end
end
