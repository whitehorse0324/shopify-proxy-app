Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/sitemaps/fb-sitemap' => 'fenty#index'
  get '/sitemaps/fs-sitemap' => 'fenty#branded'
end
