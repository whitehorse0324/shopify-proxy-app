# frozen_string_literal: true

class FentyController < ApplicationController
  def index
    render plain: ('I think that there should be the content of sitemap.xml here.')
  end
end
