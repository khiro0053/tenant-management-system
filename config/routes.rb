# frozen_string_literal: true

Rails.application.routes.draw do
  get 'homes/index'
  root 'homes#index'
  namespace :api, format: "json" do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"
      resources :tenants
    end
  end
end
