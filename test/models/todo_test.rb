require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new
    @user.email = "test@test.com"
    @user.password = "1234"
    @user.password_confirmation = "1234"
    @user.save
  end
  
  test "requires title" do
    @todo = Todo.new
    @todo.user = @user
    assert_not @todo.save
  end

  test "requires user" do
    @todo = Todo.new
    @todo.title = "I really need to do this"
    assert_not @todo.save
  end

  test "creates valid todo" do
    @todo = Todo.new
    @todo.title = "My title"
    @todo.description = "My description"
    @todo.user = @user
    @todo.save

    @todo.reload

    assert_not @todo.completed 
  end
end
