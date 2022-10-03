Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/consume_model/' => 'fuel_consume#consume_model'
      get '/consume_state/' => 'fuel_consume#consume_state'
      get '/fuel_history/' => 'fuel_consume#fuel_history'
    end
  end
end
