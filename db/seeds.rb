# Plans creation
Plan.destroy_all
puts "Create Plans"
basic = Plan.create!(name: "Basic", price: 3, actuality: true, info_endo: true, algorythm: true, forum:true)
advanced = Plan.create!(name: "Advanced", price: 6, actuality: true, info_endo: true, algorythm: true, forum:true, agenda:true, webinar: true)
puts "Plans created"

# Users creation
User.destroy_all
puts "Create Users"
claire = User.create!(email: "claire@gmail.com", password: "password" )
nico = User.create!(email: "nico@gmail.com", password: "password" )
puts "Users created"

# Subscriptions creation
Subscription.destroy_all
puts "Create Subscriptions"
Subscription.create!(user: claire, plan: basic)
Subscription.create!(user: nico, plan: advanced)
puts "Subscriptions created"
