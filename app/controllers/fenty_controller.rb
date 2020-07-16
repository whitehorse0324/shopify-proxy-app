# frozen_string_literal: true

class FentyController < ApplicationController
  def index
    sitemap_text = '<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <!--  This is the parent sitemap linking to additional sitemaps for products, collections and pages as shown below. The sitemap can not be edited manually, but is kept up to date in real time.  -->
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
