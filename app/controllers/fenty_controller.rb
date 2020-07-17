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
      map.add "products/" + product.handle, :updated => product.updated_at, :period => :daily, :priority => 0.5
    end

    # Get Collections
    cc = ShopifyAPI::CustomCollection.find(:all)
    sc = ShopifyAPI::SmartCollection.find(:all)
    cc.each do |ccol|
      map.add "collections/" + ccol.handle, :updated => ccol.updated_at, :period => :daily
    end
    sc.each do |scol|
      map.add "collections/" + scol.handle, :updated => scol.updated_at, :period => :daily
    end

    # Get Pages
    pages = ShopifyAPI::Page.find(:all)
    pages.each do |pageItem|
      map.add "pages/" + pageItem.handle, :updated => pageItem.updated_at, :period => :weekly
    end
    

    map.render_to('public/sitemaps/main.xml')
    data = File.read('public/sitemaps/main.xml')
    
    # ------- Get sitemap.xml content by string -------------

    # data = '<?xml version="1.0" encoding="UTF-8"?>
    # <urlset xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1" xmlns:video="http://www.google.com/schemas/sitemap-video/1.1" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
    
    # data += "\n<url>"
    # data += "\n<loc>https://fsfbseoprototype.com/</loc>"
    # data += "\n<lastmod>2020-07-17T18:28:58Z</lastmod>"
    # data += "\n<priority>1.0</priority>"
    # data += "\n</url>"
    
    # data += "\n<url>"
    # data += "\n<loc>https://fsfbseoprototype.com/page1</loc>"
    # data += "\n<lastmod>2020-07-17T18:28:58Z</lastmod>"
    # data += "\n</url>"
    
    # data += "\n</urlset>"


    render(plain: data)
  end

  def branded
    sitemap_text = '<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <sitemap>
    <loc>https://branded.fsfbseoprototype.com/sitemap_products_1.xml?from=5340960882841&to=5340962979993</loc>
    </sitemap>
    <sitemap>
    <loc>https://branded.fsfbseoprototype.com/sitemap_pages_1.xml</loc>
    </sitemap>
    <sitemap>
    <loc>https://branded.fsfbseoprototype.com/sitemap_collections_1.xml</loc>
    </sitemap>
    <sitemap>
    <loc>https://branded.fsfbseoprototype.com/sitemap_blogs_1.xml</loc>
    </sitemap>
    </sitemapindex>'
    render(plain: sitemap_text)
  end
end
