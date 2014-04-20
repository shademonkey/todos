class TodosController < ApplicationController
  before_filter :authenticate

  def index
    @todos = @current_user.todos.order("created_at DESC")
    puts "todos"
    puts @todos.count
  end

  def create
    @todo = @current_user.todos.new create_todo_params

    if @todo.save
      render json: @todo, status: :ok
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @todo = @current_user.todos.find_by_id params[:id]

    if @todo
      if @todo.update(update_todo_params)
        head :ok
      else
        head :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  def destroy
    @todo = @current_user.todos.find_by_id params[:id]
    
    if @todo
      @todo.destroy
      head :ok
    else
      head :not_found
    end
  end

  private
  def authenticate
    if current_user.nil?
      flash[:warning] = "You must be logged in to view the todos page"
      redirect_to login_path
    end
  end

  def create_todo_params
    params.require(:todo).permit(:title, :description)
  end

  def update_todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end
