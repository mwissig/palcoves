require 'test_helper'

class UserstylesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get userstyles_edit_url
    assert_response :success
  end

end
