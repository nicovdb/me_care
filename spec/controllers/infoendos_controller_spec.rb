require 'rails_helper'

RSpec.describe InfoendosController, type: :controller do
  context "GET index" do
    render_views

    describe '#index' do
      subject { get :index }

      describe 'Visitor' do
        it 'displays the infoendos page sucessfully' do
          expect(response).to have_http_status(200)
        end
      end
    end
  end
  context "GET show" do
    render_views

    describe '#show' do
      subject { get :show }

      describe 'Visitor' do
        it 'displays the infoendo show page sucessfully' do
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
