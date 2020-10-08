class PagesController < ApplicationController
  include ProductsAndSessions
  skip_before_action :authenticate_user!, only: [:home, :team, :legals]

  def home
  end

  def team
  end

  def legals
  end

  def algorythm
    authorize(:page, :algorythm?)
  end

  def products
    define_products_and_sessions
  end
end
