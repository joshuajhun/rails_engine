Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants,     only:   [:index,:show], defaults: {format: :json} do
        collection do
          get 'find'
          get 'find_all'
        end
      end

      resources :customers,     only: [:index, :show ], defaults: {format: :json} do
        collection do
          get 'find'
          get 'find_all'
        end
      end

      resources :invoices,      only: [:index, :show ], defaults: {format: :json} do
        collection do
          get 'find'
          get 'find_all'
        end
      end

      resources :items,         only: [:index, :show ], defaults: {format: :json} do
        collection do
          get 'find'
          get 'find_all'
        end
      end

      resources :transactions,  only: [:index, :show ], defaults: {format: :json} do
        collection do
          get 'find'
          get 'find_all'
        end
      end

      resources :invoice_items, only: [:index, :show ], defaults: {format: :json} do
        collection do
          get 'find'
          get 'find_all'
        end
      end
    end
  end
end
