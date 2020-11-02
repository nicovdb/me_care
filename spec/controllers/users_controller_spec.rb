require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "GET show" do
    render_views

    describe '#show' do
      subject { get :show }

      describe 'Visitor' do
        it 'displays the profile page sucessfully' do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
