class ProductsController < ApplicationController
  def index
    @products = policy_scope(Product)
  end
end
