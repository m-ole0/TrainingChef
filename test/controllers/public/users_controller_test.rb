require "test_helper"

class Public::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_users_edit_url
    assert_response :success
  end

  test "should get favorite_recipes" do
    get public_users_favorite_recipes_url
    assert_response :success
  end

  test "should get following_recipes" do
    get public_users_following_recipes_url
    assert_response :success
  end

  test "should get check" do
    get public_users_check_url
    assert_response :success
  end
end
