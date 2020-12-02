require "rails_helper"
require_relative "../support/devise"

RSpec.describe ArticlesController, type: :controller do
  describe "GET /a-savoir" do
    login_user
    context "from logged in user" do
      it "should return 200:OK" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /a-savoir" do

    context "from not logged in user" do
      it "should redirect to sign in sign up " do
        get :index
        expect(response).to have_http_status(302)
      end
    end
  end
end
