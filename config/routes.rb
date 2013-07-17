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
      get :schools
      get :school_sub_areas
    end
  end

  resources :visualizations do
    collection do
      get :school_hierarchy
    end
  end

  root to: "schools#index"
end
