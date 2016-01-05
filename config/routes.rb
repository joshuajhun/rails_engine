Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants,     except: [:new, :edit], defaults: {format: :json}
      resources :customers,     except: [:new, :edit], defaults: {format: :json}
      resources :invoices,      except: [:new, :edit], defaults: {format: :json}
      resources :items,         except: [:new, :edit], defaults: {format: :json}
      resources :transactions,  except: [:new, :edit], defaults: {format: :json}
      resources :invoice_items, except: [:new, :edit], defaults: {format: :json}
    end
  end
end
