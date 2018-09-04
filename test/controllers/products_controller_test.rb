require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Sample App"
    @admin_user = users(:tester)
    @basic_user = users(:flash)
  end

  test "should get product index" do
    get products_path
    assert_response :success
    assert_select "title", "All Products | #{@base_title}"
  end

  test "shoud be redirected when guest isnt logged" do
    get new_product_path
    assert_redirected_to login_url
  end

  test "shoud be redirected when user isnt admin" do
    log_in_as(@basic_user)
    get new_product_path
    assert_redirected_to root_url
  end

  test "should get product new path when log in admin" do
    log_in_as(@admin_user)
    get new_product_path
    assert_response :success
    assert_select "title", "Add new product | #{@base_title}"
  end
end

