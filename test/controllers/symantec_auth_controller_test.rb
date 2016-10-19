require 'test_helper'

class SymantecAuthControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get symantec_auth_new_url
    assert_response :success
  end

  test "should get create" do
    get symantec_auth_create_url
    assert_response :success
  end

end
