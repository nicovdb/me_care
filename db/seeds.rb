# Products creation
Product.destroy_all
puts "Create Plans"
basic = Product.create!(name: "Basic", actuality: true, info_endo: true, algorythm: true, forum:true, stripe_id: "prod_HWWjYJUAk80nUh")
trial = Product.create!(name: "Trial", actuality: true, info_endo: true, algorythm: true, forum:true, agenda:true, webinar: true)
puts "Plans created"

# Users creation
User.destroy_all
puts "Create Users"
nico = User.create!(email: "nico@gmail.com", password: "password", stripe_id:"cus_HWWkBAAqicIOn2", admin: true )
puts "Users created"

# Prices creation
Price.destroy_all
puts "Create Prices"
Price.create!(product: basic, stripe_id: "price_1GxTgDBCt2fCpZSz78oYC7GC", unit_amount: 300)
Price.create!(product: trial, unit_amount: 0)
puts "Price created"
