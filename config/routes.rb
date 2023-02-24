Rails.application.routes.default_url_options[:host] = Settings.application.canonical_hostname

Rails.application.routes.draw do
  devise_for :users, path: "auth", class_name: 'User', controllers: { registrations: "users/registrations" }

  resources :users do
    member do
      post :send_invitation
    end

    resources :user_roles, only: [:new, :create, :destroy], as: :roles
  end

  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new'
    get '/sign_out' => 'devise/sessions#destroy'
    get '/sign_up' => 'devise/registrations#new'
  end


  resources :schools do
    collection do
      get :table
    end

    member do
      get :primary_contact_input
    end
  end

  resources :school_programs

  resources :community_programs do
    resources :build,
      only: [:show, :update],
      controller: 'community_programs/build'

    collection do
      get :table
    end

    member do
      put :merge
      put :toggle_active
    end
  end

  resources :organizations do
    collection do
      get :table
    end

    member do
      get :verification
      get :primary_contact_input
    end
  end

  resources :events do
    collection do
      get :table
    end
  end

  resources :quality_elements do
    member do
      get :service_type_inputs
    end
  end

  resources :service_types

  resources :api do
    collection do
      get :community_programs
      get :school_hierarchy
      get :schools
      get :school_sub_areas
    end
  end

  scope 'api' do
    if Settings.application.public_view_enabled
      get 'config/school_map', to: 'api/configuration#school_map'
      get 'schools/map_markers/:site_type', to: 'api/schools#map_markers'
    end
  end

  resources :visualizations do
    collection do
      get :school_hierarchy
    end
  end

  namespace :admin do
    resources :dashboard, only: :index
    resources :public_authorizations, only: [:show] do
      collection do
        post :community_program
        post :organization
      end
    end
  end

  if Settings.application.public_view_enabled
    namespace :public do
      resources :schools, only: [:show]
      resources :organizations, only: [:show]
      resources :community_programs, only: [:show]
    end

    root to: "public/special#home"
  else
    root to: "schools#index"
  end
end
