# # Products creation
# Product.destroy_all
# puts "Create Plans"
# basic = Product.create!(name: "Basic", actuality: true, info_endo: true, algorythm: true, forum:true, stripe_id: "prod_HWWjYJUAk80nUh")
# trial = Product.create!(name: "Trial", actuality: true, info_endo: true, algorythm: true, forum:true, agenda:true, webinar: true)
# puts "Plans created"

# # Users creation
User.destroy_all
puts "Create Users"
nico = User.create(email: "nico@gmail.com", password: "Password1%", stripe_id:"cus_HWWkBAAqicIOn2", admin: true, first_name: "nico", last_name: "vdb" )
puts "Users created"

# # Prices creation
# Price.destroy_all
# puts "Create Prices"
# Price.create!(product: basic, stripe_id: "price_1GxTgDBCt2fCpZSz78oYC7GC", unit_amount: 300)
# Price.create!(product: trial, unit_amount: 0)
# puts "Price created"

FamMemberAnte.destroy_all
FamMemberAnte.create!(title: 'mère')
FamMemberAnte.create!(title: 'soeur')
FamMemberAnte.create!(title: 'tante')
FamMemberAnte.create!(title: 'grand-mère')

Disease.destroy_all
Disease.create!(name: 'Pathologie thyroïdienne (Hashimoto ou Basedow)')
Disease.create!(name: 'Fibromyalgie')
Disease.create!(name: 'Syndrome d’Ehlers-Danlos')
Disease.create!(name: 'Maladie de Crohn')
Disease.create!(name: 'Rectocolite hémorragique')
Disease.create!(name: 'Maladie coeliaque')
Disease.create!(name: 'Vitiligo')
Disease.create!(name: 'Psoriasis')
Disease.create!(name: 'Sclérose en plaques')
Disease.create!(name: 'Lupus')
Disease.create!(name: 'Polyarthrite rhumatoïde')
Disease.create!(name: 'Autres')

AlternativeTherapy.destroy_all
AlternativeTherapy.create!(name:'Naturopathie')
AlternativeTherapy.create!(name:'Homéopathie')
AlternativeTherapy.create!(name:'Aromathérapie')
AlternativeTherapy.create!(name:'Acupuncture')
AlternativeTherapy.create!(name:'Alimentation anti-inflammatoire')
AlternativeTherapy.create!(name:'Autre')
