require "test_helper"

class DailiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dailies_index_url
    assert_response :success
  end

  test "should get show" do
    get dailies_show_url
    assert_response :success
  end

  test "should get create" do
    get dailies_create_url
    assert_response :success
  end

  test "should get update" do
    get dailies_update_url
    assert_response :success
  end

  test "should get destroy" do
    get dailies_destroy_url
    assert_response :success
  end
end
