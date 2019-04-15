Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :accounts do
    resources :transactions do 
      collection do
        get :search
        get :advance_search
        get :deposit
        get :withdraw
        post :deposit_funds
        post :withdraw_funds
      end
    end
  end

  resources :users do  
    resources :accounts
    collection do 
      post :sign_in
    end
    member do
      get :dashboard
      get :logout
      get :close
      
    end
  end

end
