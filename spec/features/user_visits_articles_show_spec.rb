require 'rails_helper'

# feature "User visits article show page" do
#   let(:user) { User.create!(email: 'test@gmail.com', password: "Password1%", password_confirmation: "Password1%", first_name: "Claire", last_name: 'Gautier', pseudo: "clairegtr") }
#   let(:article) { @article = Article.new(title: 'Article test',
#                                     user: user,
#                                     content: 'Test content',
#                                     category: 3,
#                                     media_type: 3,
#                                     reading_time: '1 minute',
#                                     author: 'Equipe easy endo',
#                                     cover_credit: "Photographe")
#                   @article.cover.attach(io: File.open(Rails.root.join('spec', 'features', 'images', 'cover.png')), filename: 'cover.png', content_type: 'image/png')
#                   @article.save }
#   #login et confirmmer le user

#   scenario "Successfully" do
#     visit "/news/1"

#     expect(page).to have_content('Temps de lecture')

#   end
# end
