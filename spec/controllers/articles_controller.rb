require "rails_helper"
require_relative "../support/devise"

RSpec.describe ArticlesController, type: :controller do
  describe "GET /news" do
    login_user

    context "from login user" do
      it "should return 200:OK" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
