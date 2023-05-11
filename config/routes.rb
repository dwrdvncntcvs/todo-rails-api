Rails.application.routes.draw do
  #TODOS ROUTES
  get 'todos/', to: "todos#index"
  post 'todos/', to: "todos#create"
  put 'todos/:todo_id', to: "todos#update"
  delete 'todos/:todo_id', to: "todos#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
