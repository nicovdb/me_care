require 'rails_helper'

feature "User visits articles page" do
  scenario "Successfully" do
    visit articles_path

    expect(page).to have_content('News')

  end
end
