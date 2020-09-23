# # Products creation
Product.destroy_all
puts "Create Plans"
basic = Product.create!(name: "Basic", actuality: true, info_endo: true, algorythm: true, forum:true, stripe_id: "prod_HWWjYJUAk80nUh")
trial = Product.create!(name: "Trial", actuality: true, info_endo: true, algorythm: true, forum:true, agenda:true, webinar: true)
puts "Plans created"

# # Users creation
User.destroy_all
puts "Create Users"
nico = User.create(email: "nico@gmail.com", password: "Password1%", stripe_id:"cus_HWWkBAAqicIOn2", admin: true, first_name: "nico", last_name: "vdb" )
puts "Users created"

# # Prices creation
Price.destroy_all
puts "Create Prices"
Price.create!(product: basic, stripe_id: "price_1GxTgDBCt2fCpZSz78oYC7GC", unit_amount: 300)
Price.create!(product: trial, unit_amount: 0)
puts "Price created"

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
