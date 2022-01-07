Rails.application.routes.draw do
  root "top#index"
  get "about" => "top#about", as: "about"
  get "inquiries" => "top#inquiries", as: "inquiry"
  get "bad_request" => "top#bad_request"
  get "forbidden" => "top#forbidden"
  get "internal_server_error" => "top#internal_server_error"

  1.upto(18) do |n|
    get "lesson/step#{n}(/:name)" => "lesson#step#{n}"
  end

  resources :members, only: [:index, :show] do
    get "search", on: :collection
    resources :entries, only: [:index]
  end

  resources :schedules do
    get "confirmation", on: :member
    get "ask", on: :member
    get "negotiation", on: :member
    patch "demand", on: :member
    get "approval_confirmation", on: :member
    get "non_approval_confirmation", on: :member
    patch "approval", on: :member
    patch "non_approval", on: :member
    get "work", on: :member
  end

  resources :ryokans do
    get "request_confirmation", on: :collection
    get "demand_confirmation", on: :collection
    get "search", on: :collection
  end

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only:[:show, :edit, :update]

  resources :articles, only: [:index, :show]
  resources :entries do
    patch "like", "unlike", on: :member
    get "voted", on: :collection
    resources :images, controller: "entry_images" do
      patch :move_higher, :move_lower, on: :member
    end
  end
  namespace :admin do
    root "top#index"
    resources :members do
      get "search", on: :collection
    end
    resources :articles
  end
  namespace :admin do
    root "top#index"
    resources :ryokans
  end
  namespace :admin do
    root "top#index"
    resources :schedules do
      get "search", on: :collection
      get "work", on: :member
    end
  end

end
