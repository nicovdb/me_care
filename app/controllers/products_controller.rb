class ProductsController < ApplicationController
  include ProductsAndSessions
  def index
    define_products_and_sessions
  end
end
