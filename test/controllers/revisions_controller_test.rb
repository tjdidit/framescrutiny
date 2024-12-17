require "test_helper"

class RevisionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get revisions_index_url
    assert_response :success
  end

  test "should get create" do
    get revisions_create_url
    assert_response :success
  end

  test "should get update" do
    get revisions_update_url
    assert_response :success
  end

  test "should get destroy" do
    get revisions_destroy_url
    assert_response :success
  end
end
