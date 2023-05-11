class TodosController < ApplicationController
  before_action :set_todo, only: %i[update done destroy]

  def index
    @todo = Todo.all

    render json: @todo, status: :ok
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      render json: todo_params,
             status: :ok
    else
      render json: { errors: @todo.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      @todo = set_todo

      render json: { todo: @todo, message: 'Todo updated successfully' },
             status: :ok
    else
      render json: { errors: @todo.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    render json: { message: "#{@todo.title}' deleted successfully" },
           status: :ok
  end

  def done
    if @todo.update(is_done: true)
      @todo = set_todo

      render json: { todo: @todo, message: "'#{@todo.title}' is done!" },
             status: :ok
    else
      render json: { errors: @todo.errors },
             status: :unprocessable_entity
    end
  end

  private

  def set_todo
    @todo = Todo.find_by(id: params[:todo_id]) || nil

    if @todo.nil?
      render json: { errors: { message: 'Todo not found' } },
             status: :not_found
    else
      @todo
    end
  end

  def todo_params
    params.require(:todo).permit(:title, :desc)
  end
end
