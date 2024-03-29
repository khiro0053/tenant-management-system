# frozen_string_literal: true

Rails.application.routes.draw do
  get "homes/index"
  root "homes#index"
  namespace :api, format: "json" do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations",
        sessions: "api/v1/auth/sessions",
      }
      resources :tenants
      resources :tenant_groups
      resources :rooms
    end
  end
end
