require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do

    @adminuser = User.create(username: "admin",
                              email: "admin@admin.com", 
                              password: "admin", 
                              admin: true)
    sign_in_as (@adminuser)
  end
  test "get new category form and test category" do
    get "/categories/new"
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: {name: "Travel"} }
      assert_response :redirect
    end
    follow_redirect! 
    assert_response :success
    assert_match "Travel", response.body
  end

  test "get new category and reject if invalid" do
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: { category: {name: " "} }
    end 
    assert_match "An error occured.", response.body
  end
end
