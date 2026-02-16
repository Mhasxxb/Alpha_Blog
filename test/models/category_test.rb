require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "Category should be valid" do
    @category = Category.new(name: "Sports")
    assert @category.valid?
  end

  test "Name should be present" do
    @category = Category.new(name: " ")
    assert_not @category.valid?
  end

  test "Name should be unique" do
    @category1 = Category.new(name: "Cats")
    @category2 = Category.new(name: "Cats")
    @category1.save
    assert_not @category2.valid?

  end

  test "Name should not be too long" do
    name = "hello" * 6
    @category = Category.new(name: name)
    assert_not @category.valid?
  end

  test "Name should not be too short" do

    @category = Category.new(name: "he")
    assert_not @category.valid?

  end

end