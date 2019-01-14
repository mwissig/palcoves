require 'test_helper'

class PmsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pms_index_url
    assert_response :success
  end

  test "should get show" do
    get pms_show_url
    assert_response :success
  end

end
