Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root :to => 'welcome#newport'

  # root :to => 'intro#index'

  get 'intro', to: 'intro#index', as: :landing_page

  get 'welcome/warwick', to: 'welcome#warwick', as: :warwick_intro
  get 'welcome/west-warwick', to: 'welcome#west-warwick', as: :west_warwick_intro 
  get 'welcome/newport', to: 'welcome#newport', as: :newport_intro
  # get 'enrollment/summary', to: 'enrollment#summary', as: :happy_libs_summary

  get 'admin', to: 'admin#index'

  get 'admin/login', to: 'admin#admin_login'
  post 'admin/login', to: 'admin#admin_login'

  # -----------------------
  # Central Admin Setup
  # -----------------------

  get 'admin/central/setup', to: 'admin#central_setup_welcome'

  get 'admin/central/setup/info', to: 'admin#central_setup_info_get'
  post 'admin/central/setup/info', to: 'admin#central_setup_info_post'

  get 'admin/central/setup/confirm', to: 'admin#central_setup_confirm'

  # -----------------------
  # Central Admin Supplemental Materials
  # -----------------------

  get 'admin/central/supplemental_materials', to: 'admin#central_supplemental_materials'

  get 'admin/central/supplemental_materials/add', to: 'admin#central_supplemental_materials_add_get'
  post 'admin/central/supplemental_materials/add', to: 'admin#central_supplemental_materials_add_post'

  resources :enrollment

  resources :madlibs

  resources :students

  resources :schools

  resources :admin

  # get 'pages/home' => 'high_voltage/pages#show', id: 'home'

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
