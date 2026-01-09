require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com",
                              password: "password", admin: true)
    sign_in_as(@admin_user)
  end
  
  test "get new category form and create category" do
    # sign_in_as(@user, "password")
    # get new_category_path
    # assert_template 'categories/new'
    # assert_difference 'Category.count', 1 do
    #   post categories_path, params: { category: { name: "Sports"} }
    #   follow_redirect!
    # end
    # assert_template 'categories/index'
    # assert_match "Sports", response.body
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "Sports"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "invalid form submission results in failure" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " "} }
      assert_response :success
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
  
  # test "invalid form submission results in failure" do
  #   sign_in_as(@user, "password")
  #   get new_category_path
  #   assert_template 'categories/new'
  #   assert_no_difference 'Category.count' do
  #     post categories_path, params: { category: { name: ""} }
  #   end
  #   assert_template 'categories/new'
  #   assert_select 'h2.panel-title'
  #   assert_select 'div.panel-body'
  # end
end