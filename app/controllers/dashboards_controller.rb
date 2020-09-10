class DashboardsController < ApplicationController
  def show
    authorize :dashboard
    @articles = policy_scope(Article)
  end
end
