require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "requires email address" do
    @user = User.new
    @user.password = "1234"
    @user.password_confirmation = "1234"
    assert_not @user.save
  end
  
  test "requires password" do
    @user = User.new
    @user.email = "andy@aol.com"
    @user.password_confirmation = "1234"
    assert_not @user.save
  end
  
  test "requires password confirmation" do
    @user = User.new
    @user.email = "andy@aol.com"
    @user.password = "1234"
    assert_not @user.save
  end
  
  test "password_confirmation and password must match" do
    @user = User.new
    @user.email = "andy@aol.com"
    @user.password = "4321"
    @user.password_confirmation = "1234"
    assert_not @user.save
  end
  
  test "should create valid user" do
    @user = User.new
    @user.email = "andy@aol.com"
    @user.password = "4321"
    @user.password_confirmation = "4321"
    assert @user.save
  end
  
  
end
