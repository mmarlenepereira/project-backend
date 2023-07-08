Rails.application.routes.draw do
  resources :clients do
    collection do
      get :search
    end
    member do
      get :order_count
    end
    resources :purchases, except: [:index, :show]
    delete :destroy, on: :member
  end

  resources :purchases, only: [:index, :show, :create, :update] do
    collection do
      get :search
    end
    delete :destroy, on: :member
  end
end

