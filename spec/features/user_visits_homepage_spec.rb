require 'rails_helper'

feature "User visits homepage" do
  scenario "Successfully" do
    visit root_path

    expect(page).to have_css 'h1', text: 'easy endo vous aide à mieux vivre votre endométriose'

  end
end
