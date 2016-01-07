require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    get :index, format: :json
    assert_response :success
  end

  test '#index returns and array of records' do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of items' do
    get :index, format: :json

    assert_equal Transaction.count, json_response.count
  end

  test '#index contains correct properties' do
  get :index, format: :json

    json_response.each do |transaction|
      assert transaction["result"]
      assert transaction['invoice_id']
      assert transaction['credit_card_number']
      assert transaction['result']
    end
  end


  test '#show returns correct transaction' do
    create(:transaction)
    get :show, format: :json, id: Transaction.first.id
    assert_response :success
    assert_equal Transaction.first.id, json_response['id']
  end

  test '#show returns 1 transaction' do
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
