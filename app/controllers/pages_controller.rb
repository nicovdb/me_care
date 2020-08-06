class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :team, :legals, :policy, :conditions ]

  def home
  end

  def team
  end

  def legals
  end

  def policy
  end

  def conditions
  end

  def algorythm
  end
end
