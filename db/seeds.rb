# Products creation
Product.destroy_all
puts "Create Plans"
basic = Product.create!(name: "Basic", actuality: true, info_endo: true, algorythm: true, forum:true, stripe_id: "prod_HWWjYJUAk80nUh")
# advanced = Product.create!(name: "Advanced", price: 6, actuality: true, info_endo: true, algorythm: true, forum:true, agenda:true, webinar: true)
puts "Plans created"

# Users creation
User.destroy_all
puts "Create Users"
nico = User.create!(email: "nico@gmail.com", password: "password", stripe_id:"cus_HWWkBAAqicIOn2" )
puts "Users created"

# Prices creation
Price.destroy_all
puts "Create Prices"
Price.create!(product: basic, stripe_id: "price_1GxTgDBCt2fCpZSz78oYC7GC")
puts "Price created"

# Subscriptions creation
# Subscription.destroy_all
# puts "Create Subscriptions"
# Subscription.create!(user: claire, plan: basic)
# Subscription.create!(user: nico, plan: advanced)
# puts "Subscriptions created"
