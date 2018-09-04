require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
      @base_title = "Sample App"
      @admin_user = users(:tester)
      @basic_user = users(:flash)
  end
  
  test "should get root" do
    get root_path
    assert_response :success
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "shoud be redirected when guest isnt logged" do
    get admin_path
    assert_redirected_to login_url
  end

  test "shoud be redirected when user isnt admin" do
    log_in_as(@basic_user)
    get admin_path
    assert_redirected_to root_url
  end
end

