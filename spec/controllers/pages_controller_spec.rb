require 'rails_helper'
require_relative "../support/devise"

RSpec.describe PagesController, type: :controller do

  describe 'pages controller' do

    render_views

    describe '#home' do
      subject { get :home }

      describe 'Visitor' do
        it 'displays the home page sucessfully' do
          expect(subject).to have_http_status(200)
        end
      end
    end

  end

end
