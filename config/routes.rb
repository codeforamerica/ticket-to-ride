Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root :to => 'welcome#choose_district'

  get '/', to: 'welcome#choose_district'
  post '/', to: 'welcome#welcome'
  get 'district/:district_url', to: 'welcome#welcome'

  get '/enrollment/district/:district_url', to: 'enrollment#show', district_url: /[a-z0-9\-]+/i

  get 'intro', to: 'intro#index', as: :landing_page


  # -----------------------
  # Admin Login
  # -----------------------

  get 'admin', to: 'admin#index'

  get 'admin/login', to: 'admin#admin_login'
  post 'admin/login', to: 'admin#admin_login'

  get 'admin/central', to: 'admin#admin_login'
  get 'admin/district', to: 'admin#admin_login'

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

  # TODO adjust singular / plural use

  get 'admin/central/supplemental_materials', to: 'admin#central_supplemental_materials'

  get 'admin/central/supplemental_materials/add', to: 'admin#central_supplemental_materials_add_get'
  post 'admin/central/supplemental_materials/add', to: 'admin#central_supplemental_materials_add_post'

  get 'admin/central/supplemental_materials/edit/:id', to: 'admin#central_supplemental_materials_edit_get'
  post 'admin/central/supplemental_materials/edit/:id', to: 'admin#central_supplemental_materials_edit_post'

  get 'admin/central/supplemental_materials/delete/:id', to: 'admin#central_supplemental_materials_delete_get'
  post 'admin/central/supplemental_materials/delete/:id', to: 'admin#central_supplemental_materials_delete_post'


  # -----------------------
  # Central Admin People
  # -----------------------

  # TODO adjust singular / plural use

  get 'admin/central/people', to: 'admin#central_people'

  get 'admin/central/people/add', to: 'admin#central_people_add_get'
  post 'admin/central/people/add', to: 'admin#central_people_add_post'

  get 'admin/central/people/edit/:id', to: 'admin#central_people_edit_get'
  post 'admin/central/people/edit/:id', to: 'admin#central_people_edit_post'

  get 'admin/central/people/delete/:id', to: 'admin#central_people_delete_get'
  post 'admin/central/people/delete/:id', to: 'admin#central_people_delete_post'


  # -----------------------
  # District Admin Setup
  # -----------------------

  get 'admin/district/setup/:admin_user_id', to: 'admin#district_setup_get'
  post 'admin/district/setup/:admin_user_id', to: 'admin#district_setup_post'

  # -----------------------
  # District Admin - Applications
  # -----------------------

  get 'admin/district/applications', to: 'admin#district_applications_unprocessed'
  get 'admin/district/applications/:page', to: 'admin#district_applications_unprocessed', page: /\d+/

  get 'admin/district/applications/processed', to: 'admin#district_applications_processed'
  get 'admin/district/applications/processed/:page', to: 'admin#district_applications_processed', page: /\d+/

  get 'admin/district/application/:student_id', to: 'admin#district_application_detail_get', student_id: /\d+/

  get 'admin/district/application/edit/:student_id', to: 'admin#district_application_edit_get', student_id: /\d+/
  post 'admin/district/application/edit/:student_id', to: 'admin#district_application_edit_post', student_id: /\d+/

  get 'admin/district/application/process/:student_id', to: 'admin#district_application_process_get', student_id: /\d+/
  post 'admin/district/application/process/:student_id', to: 'admin#district_application_process_post', student_id: /\d+/

  # -----------------------
  # District Admin - District info
  # -----------------------

  get 'admin/district/info', to: 'admin#district_info_get'
  post 'admin/district/info', to: 'admin#district_info_post'

  # -----------------------
  # District Admin Supplemental Materials
  # -----------------------

  # TODO adjust singular / plural use

  get 'admin/district/supplemental_materials', to: 'admin#district_supplemental_materials'

  get 'admin/district/supplemental_materials/add', to: 'admin#district_supplemental_materials_add_get'
  post 'admin/district/supplemental_materials/add', to: 'admin#district_supplemental_materials_add_post'

  get 'admin/district/supplemental_materials/edit/:id', to: 'admin#district_supplemental_materials_edit_get'
  post 'admin/district/supplemental_materials/edit/:id', to: 'admin#district_supplemental_materials_edit_post'

  get 'admin/district/supplemental_materials/delete/:id', to: 'admin#district_supplemental_materials_delete_get'
  post 'admin/district/supplemental_materials/delete/:id', to: 'admin#district_supplemental_materials_delete_post'

  # -----------------------
  # District People
  # -----------------------

  # TODO adjust singular / plural use

  get 'admin/district/people', to: 'admin#district_people'

  get 'admin/district/people/add', to: 'admin#district_people_add_get'
  post 'admin/district/people/add', to: 'admin#district_people_add_post'

  get 'admin/district/people/edit/:id', to: 'admin#district_people_edit_get'
  post 'admin/district/people/edit/:id', to: 'admin#district_people_edit_post'

  get 'admin/district/people/delete/:id', to: 'admin#district_people_delete_get'
  post 'admin/district/people/delete/:id', to: 'admin#district_people_delete_post'

  # -----------------------
  # District - Export Settings
  # -----------------------
  get 'admin/district/export', to: 'admin#export_settings_get'
  post 'admin/district/export', to: 'admin#export_settings_post'

  get 'admin/district/export/now', to: 'admin#export_processed_now'


  resources :enrollment

  resources :students

  resources :admin
end
