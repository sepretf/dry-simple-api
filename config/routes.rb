# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :users do
        post '/', to: 'create#call'

        namespace :login do
          post '/', to: 'create#call'
          get '/auto_login',  to: 'show#call'
        end
      end
    end
  end
end
