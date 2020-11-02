require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  context "GET index" do
    render_views

    describe '#index' do
      subject { get :index }

      describe 'Visitor' do
        it 'displays the articles page sucessfully' do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
  context "GET show" do
    render_views

    describe '#show' do
      subject { get :show }

      describe 'Visitor' do
        it 'displays the article show page sucessfully' do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
