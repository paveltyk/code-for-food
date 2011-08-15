CodeForFood::Application.routes.draw do

  resources :invitations, :only => [:show, :new, :create] do
    member do
      put :resend
    end
  end


  resources :feedbacks, :only => [:new, :create]
  resources :password_resets, :except => [:index, :show, :destroy]
  resources :questions, :only => [:index, :new, :create] do
    resources :answers, :only => [:new, :create]
  end

  namespace :admin do
    root :to => "users#index"
    resources :orders, :only => [:show, :edit, :update, :destroy]
    resources :tags, :as => :dish_tags

    resources :menus do
      member do
        put :lock
        put :publish
        match "/reports/provider" => "reports#provider", :as => :provider_report_for, :via => :get
      end
    end

    resources :users do
      resources :payment_transactions, :except => :show
    end
  end

  match "/login" => "sessions#new", :as => :login, :via => :get
  match "/login" => "sessions#create", :via => :post
  match "/logout" => "sessions#destroy", :as => :logout

  match "/register/:invitation_token" => "users#new", :as => :register, :via => :get
  match "/register" => "users#create", :as => :do_registration, :via => :post
  match "/profile/edit" => "users#edit", :as => :edit_profile, :via => :get
  match "/profile" => "users#update", :as => :profile, :via => :put

  scope "/:date", :constraints => {:date => /\d{4}-\d{2}-\d{2}/} do
    resource :order, :only => [:show, :create, :update, :destroy]
  end

  resource :balance, :controller => 'balance', :only => :show

  root :to => "orders#show", :date => "today"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

