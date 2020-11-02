require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe 'pages controller' do

    render_views

    describe '#home' do
      subject { get :home }

      describe 'Visitor' do
        it 'displays the home page sucessfully' do
          expect(response).to have_http_status(:success)
        end
      end
    end

    describe '#team' do
      subject { get :team }

      describe 'Visitor' do
        it 'displays the team page sucessfully' do
          expect(response).to have_http_status(:success)
        end
      end
    end

    describe '#legals' do
      subject { get :legals }

      describe 'Visitor' do
        it 'displays the legals page sucessfully' do
          expect(response).to have_http_status(:success)
        end
      end
    end

    describe '#algorythm' do
      subject { get :algorythm }

      describe 'Visitor' do
        it 'displays the algorythm page sucessfully' do
          expect(response).to have_http_status(:success)
        end
      end
    end

  end

end
