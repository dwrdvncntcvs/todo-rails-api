Rails.application.routes.draw do
  # TODOS ROUTES
  get 'todos/', to: 'todos#index'
  post 'todos/', to: 'todos#create'
  put 'todos/:todo_id', to: 'todos#update'
  put 'todos/done/:todo_id', to: 'todos#done'
  delete 'todos/:todo_id', to: 'todos#destroy'
end
