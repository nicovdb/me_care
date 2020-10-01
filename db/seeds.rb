# # Products creation
Product.destroy_all
puts "Create Plans"
six_months = Product.create!(name: "6 mois", stripe_id: "prod_I7dS8GEPry5nsh")
three_months = Product.create!(name: "3 mois", stripe_id: "prod_I7dNM5AhD0yKcR")
trial = Product.create!(name: "Trial")
puts "Plans created"

# # Prices creation
Price.destroy_all
puts "Create Prices"
Price.create!(product: six_months, stripe_id: "price_1HXOC3BCt2fCpZSzWnwwb2tF", unit_amount: 2500, nickname: "6 mois")
Price.create!(product: three_months, stripe_id: "price_1HXO6gBCt2fCpZSzrOskt8KL", unit_amount: 1500, nickname: "3 mois")
Price.create!(product: trial, unit_amount: 0, nickname: "Trial")
puts "Price created"

# # Users creation
User.destroy_all
puts "Create Users"
nico = User.create(email: "nicolasvandenbussche0@gmail.com", password: "Password1%", admin: true, first_name: "Nicolas", last_name: "Vandenbussche", pseudo: "nicovdb" )
puts "Users created"

FamMemberAnte.destroy_all
FamMemberAnte.create!(title: 'mère')
FamMemberAnte.create!(title: 'soeur')
FamMemberAnte.create!(title: 'tante')
FamMemberAnte.create!(title: 'grand-mère')
puts "Fam member created"

Disease.destroy_all
Disease.create!(name: 'Pathologie thyroïdienne (Hashimoto ou Basedow)', displayed: true)
Disease.create!(name: 'Fibromyalgie', displayed: true)
Disease.create!(name: 'Syndrome d’Ehlers-Danlos', displayed: true)
Disease.create!(name: 'Maladie de Crohn', displayed: true)
Disease.create!(name: 'Rectocolite hémorragique', displayed: true)
Disease.create!(name: 'Maladie coeliaque', displayed: true)
Disease.create!(name: 'Vitiligo', displayed: true)
Disease.create!(name: 'Psoriasis', displayed: true)
Disease.create!(name: 'Sclérose en plaques', displayed: true)
Disease.create!(name: 'Lupus', displayed: true)
Disease.create!(name: 'Polyarthrite rhumatoïde', displayed: true)
puts "Diseases created"

AlternativeTherapy.destroy_all
AlternativeTherapy.create!(name:'Naturopathie', displayed: true)
AlternativeTherapy.create!(name:'Homéopathie', displayed: true)
AlternativeTherapy.create!(name:'Aromathérapie', displayed: true)
AlternativeTherapy.create!(name:'Acupuncture', displayed: true)
AlternativeTherapy.create!(name:'Alimentation anti-inflammatoire', displayed: true)
puts "Therapies created"
