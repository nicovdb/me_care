# FamMemberAnte.destroy_all
# FamMemberAnte.create!(title: 'mère')
# FamMemberAnte.create!(title: 'soeur')
# FamMemberAnte.create!(title: 'tante')
# FamMemberAnte.create!(title: 'grand-mère')
# puts "Fam member created"

# Disease.destroy_all
# Disease.create!(name: 'Pathologie thyroïdienne (Hashimoto ou Basedow)', displayed: true)
# Disease.create!(name: 'Fibromyalgie', displayed: true)
# Disease.create!(name: 'Syndrome d’Ehlers-Danlos', displayed: true)
# Disease.create!(name: 'Maladie de Crohn', displayed: true)
# Disease.create!(name: 'Rectocolite hémorragique', displayed: true)
# Disease.create!(name: 'Maladie coeliaque', displayed: true)
# Disease.create!(name: 'Vitiligo', displayed: true)
# Disease.create!(name: 'Psoriasis', displayed: true)
# Disease.create!(name: 'Sclérose en plaques', displayed: true)
# Disease.create!(name: 'Lupus', displayed: true)
# Disease.create!(name: 'Polyarthrite rhumatoïde', displayed: true)
# puts "Diseases created"

# AlternativeTherapy.destroy_all
# AlternativeTherapy.create!(name:'Naturopathie', displayed: true)
# AlternativeTherapy.create!(name:'Homéopathie', displayed: true)
# AlternativeTherapy.create!(name:'Aromathérapie', displayed: true)
# AlternativeTherapy.create!(name:'Acupuncture', displayed: true)
# AlternativeTherapy.create!(name:'Alimentation anti-inflammatoire', displayed: true)
# puts "Therapies created"
User.where('email like ?', '%@mail.ru').destroy_all
