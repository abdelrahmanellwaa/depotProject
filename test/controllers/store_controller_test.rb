require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    #gets the index and asserts that a successful 
    #response is expected and found in the server
    get store_index_url
    assert_response :success




  end

end
