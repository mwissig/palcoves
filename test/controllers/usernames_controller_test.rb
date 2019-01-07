require 'test_helper'

class UsernamesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get usernames_new_url
    assert_response :success
  end

  test "should get index" do
    get usernames_index_url
    assert_response :success
  end

  test "should get edit" do
    get usernames_edit_url
    assert_response :success
  end

  test "should get show" do
    get usernames_show_url
    assert_response :success
  end

end
