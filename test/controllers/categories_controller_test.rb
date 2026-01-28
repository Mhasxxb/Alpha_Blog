require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")

    @adminuser = User.create(username: "admin",
                              email: "admin@admin.com", 
                              password: "admin", 
                              admin: true)
    # byebug
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@adminuser)
    get new_category_url
    assert_response :success
  end

  test "should not create category if not admin" do

    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "Motivational" } }
    end
    assert_redirected_to categories_url 
  end

  test "should create category" do
    sign_in_as(@adminuser)
    assert_difference('Category.count', 1) do # when a category will be created the prev count and current count should must differ by 1 
      post categories_url, params: { category: { name: "Motivational" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end

end
