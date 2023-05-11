class TodosController < ApplicationController
  def index; end

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

  def update; end

  def destroy; end

  private

  def todo_params
    params.require(:todo).permit(:title, :desc)
  end
end
