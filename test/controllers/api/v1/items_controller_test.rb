require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "api serves up the index " do
    get :index, format: :json
    assert_response :success
  end

  test 'api allows you to view the show of a specific item' do
    get :show, format: :json, id: 1
    assert_response :success
  end

  test 'you can find by a single attribute' do
    get :find, format: :json, name: "Item Autem Minima"
    assert_response :success

    get :find, format: :json, description: 'Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.'
    assert_response :success
  end

  test 'case does not matter with a single attribute' do
    get :find, format: :json, name: 'item autem minima'
    assert_response :success

    get :find, format: :json, name: 'ITEM autem MINIMA'
    assert_response :success
  end

  test ' you can find a item by id' do
    get :find, format: :json, id: 1
    assert_response :success
  end
end
