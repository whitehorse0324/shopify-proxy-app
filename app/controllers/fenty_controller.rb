# frozen_string_literal: true

class FentyController < ApplicationController
  require 'xml-sitemap'
  require 'shopify_api'

  def index
    # Create sitemap object
    map = XmlSitemap::Map.new('fsfbseoprototype.com', :secure => true)
    # Connect shopify store by shopify api
    shop_url = "https://#{ENV['SHOPIFY_API_ACCESS_KEY']}:#{ENV['SHOPIFY_API_ACCESS_PASSWORD']}@fsfbseoprototype.myshopify.com"
    ShopifyAPI::Base.site = shop_url
    ShopifyAPI::Base.api_version = ENV['SHOPIFY_API_VERSION']
    
    # Get Products
    products = ShopifyAPI::Product.find(:all, params: {
      limit: 250
    })
    while products.next_page?
      products = products.fetch_next_page
      sleep(1.second)
    end
    
    products.each do |product|
      if product.vendor == 'main' and (product.published_scope == 'global' or product.published_scope == 'web') and product.published_at
        map.add "products/" + product.handle, :updated => product.updated_at, :period => :hourly
      end
    end

    # Get Collections
    cc = ShopifyAPI::CustomCollection.find(:all)
    sc = ShopifyAPI::SmartCollection.find(:all)
    cc.each do |ccol|
      if ccol.published_at
        map.add "collections/" + ccol.handle, :updated => ccol.updated_at, :period => :hourly
      end
    end
    sc.each do |scol|
      if ccol.published_at
        map.add "collections/" + scol.handle, :updated => scol.updated_at, :period => :hourly
      end
    end

    # Get Pages
    pages = ShopifyAPI::Page.find(:all)
    pages.each do |pageItem|
      if pageItem.published_at
        map.add "pages/" + pageItem.handle, :updated => pageItem.updated_at, :period => :hourly
      end
    end

    # Get blogs
    blogs = ShopifyAPI::Blog.find(:all)
    blogs.each do |blogItem|
      map.add "blogs/" + blogItem.handle, :updated => blogItem.updated_at, :period => :hourly
    end

    # Get Articles
    articles = ShopifyAPI::Article.find(:all)
    articles.each do |articleItem|
      if articleItem.published_at
        map.add "articles/" + articleItem.handle, :updated => articleItem.updated_at, :period => :hourly
      end
    end
    

    map.render_to('public/sitemaps/main.xml')
    data = File.read('public/sitemaps/main.xml')
    
    render(plain: data)
  end

  def branded
    # Create sitemap object
    map = XmlSitemap::Map.new('branded.fsfbseoprototype.com', :secure => true)
    # Connect shopify store by shopify api
    shop_url = "https://#{ENV['SHOPIFY_API_ACCESS_KEY']}:#{ENV['SHOPIFY_API_ACCESS_PASSWORD']}@fsfbseoprototype.myshopify.com"
    ShopifyAPI::Base.site = shop_url
    ShopifyAPI::Base.api_version = ENV['SHOPIFY_API_VERSION']
    
    # Get Products
    products = ShopifyAPI::Product.find(:all, params: {
      limit: 250
    })
    while products.next_page?
      products = products.fetch_next_page
      sleep(1.second)
    end
    
    products.each do |product|
      if product.vendor == 'branded' and (product.published_scope == 'global' or product.published_scope == 'web') and product.published_at
        map.add "products/" + product.handle, :updated => product.updated_at, :period => :hourly
      end
    end

    # Get Collections
    cc = ShopifyAPI::CustomCollection.find(:all)
    sc = ShopifyAPI::SmartCollection.find(:all)
    cc.each do |ccol|
      if ccol.published_at
        map.add "collections/" + ccol.handle, :updated => ccol.updated_at, :period => :hourly
      end
    end
    sc.each do |scol|
      if ccol.published_at
        map.add "collections/" + scol.handle, :updated => scol.updated_at, :period => :hourly
      end
    end

    # Get Pages
    pages = ShopifyAPI::Page.find(:all)
    pages.each do |pageItem|
      if pageItem.published_at
        map.add "pages/" + pageItem.handle, :updated => pageItem.updated_at, :period => :hourly
      end
    end

    # Get blogs
    blogs = ShopifyAPI::Blog.find(:all)
    blogs.each do |blogItem|
      map.add "blogs/" + blogItem.handle, :updated => blogItem.updated_at, :period => :hourly
    end

    # Get Articles
    articles = ShopifyAPI::Article.find(:all)
    articles.each do |articleItem|
      if articleItem.published_at
        map.add "articles/" + articleItem.handle, :updated => articleItem.updated_at, :period => :hourly
      end
    end

    map.render_to('public/sitemaps/branded.xml')
    data = File.read('public/sitemaps/branded.xml')
    
    render(plain: data)
  end
end
