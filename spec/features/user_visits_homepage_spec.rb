require 'rails_helper'
require_relative "../support/devise"


feature "User visits homepage" do
  scenario "Successfully" do
    visit root_path
    @user = FactoryBot.create(:user)
    @user.confirm

    expect(page).to have_css 'h1', text: 'easy endo vous aide à mieux vivre votre endométriose'

  end
end
