# frozen_string_literal: true

class FentyController < ApplicationController
  def index
    sitemap_text = 'I think that there should be the content of sitemap.xml here.'
    render plain: sitemap_text
  end
end
