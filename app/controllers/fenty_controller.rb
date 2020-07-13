# frozen_string_literal: true

class FentyController < ApplicationController
  def index
    sitemapText = 'I think that there should be the content of sitemap.xml here.'
    render plain: (sitemapText)
  end
end
