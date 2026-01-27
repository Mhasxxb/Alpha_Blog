Rails.application.routes.draw do

  root 'pages#home'
  get 'about', to: 'pages#about'
  # resources :articles, only: [:show, "index", :new, "create", :edit, "update"] ##read the comment
  resources :articles
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  resources :users, except: ['new', 'create']

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources "categories", except: ['destroy']

end

# 1. Memory Usage (Object Recycling)
# Strings ("xcvbnm"): Every time you define "xcvbnm" in your code, Ruby creates a new object in memory, even if the content is identical. Ten uses of "xcvbnm" means ten string objects.
# Symbols (:xcvbnm): Symbols are stored in a global symbol table. Whether you use :xcvbnm once or one thousand times, Ruby reuses the exact same memory address (Object ID).
# Impact: Using symbols saves memory, especially when the same keys are used thousands of times in hashes or loops. 