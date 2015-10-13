Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/game', to: 'game#create'
    end
  end
end
