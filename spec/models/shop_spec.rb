# frozen_string_literal: true
require "rails_helper"

RSpec.describe(Shop, type: :model) do
  it "is valid with valid attributes" do
    shop = Shop.new(
      shopify_domain: "half-helix-rocks.myshopify.com",
      shopify_token: "abcd"
    )

    expect(shop).to(be_valid)
  end

  it "returns 2020-04 for the api version" do
    shop = Shop.new
    expect(shop.api_version).to(eq("2020-04"))
  end
end
