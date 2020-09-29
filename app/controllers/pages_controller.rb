class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :team, :legals]

  def home
  end

  def team
  end

  def legals
  end

  def algorythm
  end
end
