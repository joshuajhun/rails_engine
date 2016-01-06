require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific customer' do
    create(:transaction)
    get :show, format: :json, id: Transaction.first.id
    assert_response :success
    assert_equal Transaction.first.id, json_response['id']
  end

  test '#show will return for you a single record' do
    create(:transaction)
    get :show, format: :json, id: Transaction.first.id

    assert_kind_of Hash, json_response
  end

  test 'you can find by a single attribute' do
    create(:transaction)
    get :find, format: :json, id: Transaction.first.id
    assert_response :success
    assert_equal Transaction.first.id, json_response['id']

    get :find, format: :json, credit_card_number: Transaction.first.credit_card_number
    assert_response :success
    assert_equal Transaction.first.credit_card_number, json_response['credit_card_number']
  end

  test 'case does not matter with a single attribute' do
    create(:transaction)
    get :find, format: :json, result: Transaction.first.result
    assert_response :success
    assert_equal Transaction.first.result, json_response['result']

    get :find, format: :json, result: Transaction.first.result
    assert_response :success
    assert_equal Transaction.first.result, json_response['result']
  end

  test ' you can find a Transaction by id' do
    create(:transaction)
    get :find, format: :json, id: Transaction.first.id
    assert_response :success
    assert_equal Transaction.first.id, json_response['id']
  end

  test '#find returns one record' do
    create(:transaction)
    get :find, format: :json, credit_card_number: Transaction.first.credit_card_number
    assert_kind_of Hash, json_response
  end

  test "random responds to json" do
    get :random, format: :json
    assert_response :success
  end

  test '#invoice responds to json' do
    create(:transaction)
    get :invoice, format: :json, id: Transaction.first.id
    assert_response :success
  end

  test '#invoice will return the records associated with transaction' do
    invoice  = create(:invoice)
    transaction = create(:transaction, invoice: invoice)
    get :invoice, format: :json, id: transaction.id


    assert_equal transaction.invoice_id, json_response['id']
  end
end
