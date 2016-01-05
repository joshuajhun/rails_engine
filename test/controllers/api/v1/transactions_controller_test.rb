require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    get :show, format: :json, id: 1
    assert_response :success
  end

  test 'you can find by a single attribute' do
    get :find, format: :json, id: 2856
    assert_response :success

    get :find, format: :json, credit_card_number: '4800749911485986'
    assert_response :success
  end

  test 'case does not matter with a single attribute' do
    get :find, format: :json, result: 'success'
    assert_response :success

    get :find, format: :json, result: 'FAILED'
    assert_response :success
  end

  test ' you can find a Transaction by id' do
    get :find, format: :json, id: 1
    assert_response :success
  end
end
