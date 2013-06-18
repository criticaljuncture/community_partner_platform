OusdCommunityPartners::Application.routes.draw do
  devise_for :users
  resources :schools
  resources :community_partners
  resources :organizations
  resources :school_quality_indicator_sub_areas

  resources :api do
    collection do
      get :community_partners
      get :school_hierarchy
    end
  end

  resources :visualizations do
    collection do
      get :school_hierarchy
    end
  end

  root to: "community_partners#index"
end
