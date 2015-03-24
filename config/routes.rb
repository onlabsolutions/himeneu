require 'sidekiq/web'
Rails.application.routes.draw do



  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, :controllers => { registrations: 'registrations', confirmations: 'confirmations'  }
  root to: 'dashboard#index'
  get 'dashboard' => 'dashboard#index'
  get 'privacy' => 'dashboard#privacy'
  get '/anuncie' => 'static_pages#anuncie'
  get '/sobre' => 'static_pages#sobre'
  get '/contato' => 'static_pages#contato'
  get 'newpro' => 'static_pages#newpro'


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_scope :admin_user do
    authenticate :admin_user do
      mount Sidekiq::Web => 'admin/sidekiq'
    end
  end

# devise_scope :user do
#   authenticated :user do
#     root 'dashboard#index', as: :authenticated_root
#   end

#   unauthenticated do
#     root 'devise/sessions#new', as: :unauthenticated_root
#   end
# end

resources :customers do
  get 'search', on: :collection
  get 'recover', on: :collection
end

resources :providers do
  resources :address, :except => [:index, :show, :edit]
  resources :recommendations
  get 'search', on: :collection
  get 'carousel', on: :collection
  get 'recover', on: :collection
end

resources :interests, :only => :create do
  post 'change_state', on: :collection
end

resources :feature_images

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
