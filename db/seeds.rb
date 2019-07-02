# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def attach_file (file_name)
  file_path = "#{Rails.root}/db/files/#{file_name}"
  file = File.new(file_path)
  ActionDispatch::Http::UploadedFile.new(
    :filename => File.basename(file),
    :tempfile => file,
    :type => MIME::Types.type_for(file_path).first.content_type
  )
end

# Companies
cocacola = User.create({
  email: 'cocacola@email.com',
  password: '123123',
  name: 'Coca Cola',
  user_type: 'Company',
  rut: '12345678',
  description: 'Esta es la compañía cocacola. Así es, la famosa Coca Cola',
  address: 'Avenida polo norte con oso polar',
  avatar: attach_file('cocacola.jpg')
})
pepsi = User.create({
  email: 'pepsi@email.com',
  password: '123123',
  name: 'Pepsi',
  user_type: 'Company',
  rut: '12345679',
  description: 'Esta es la compañía pepsi. Así es, la copia de Coca Cola',
  address: 'Avenida polo sur con oso normal',
  avatar: attach_file('pepsi.png')
})
starbucks = User.create({
  email: 'starbucks@email.com',
  password: '123123',
  name: 'Starbucks',
  user_type: 'Company',
  rut: '12345680',
  description: 'Esta es la compañía starbucks. Así es, la de los cafés piolas y caros',
  address: 'Avenida hipster con ching ching',
  avatar: attach_file('starbucks.jpg')
})

# Donors
romano = User.create({
  email: 'romano@email.com',
  password: '123123',
  name: 'Romano',
  user_type: 'Donor',
  avatar: attach_file('romano.jpg')
})
jorge = User.create({
  email: 'jorge@email.com',
  password: '123123',
  name: 'Jorge',
  user_type: 'Donor',
  avatar: attach_file('jorge.jpg')
})
domingo = User.create({
  email: 'domingo@email.com',
  password: '123123',
  name: 'Domnigo',
  user_type: 'Donor',
  avatar: attach_file('domingo.jpg')
})
daniel = User.create({
  email: 'daniel@email.com',
  password: '123123',
  name: 'Domingo',
  user_type: 'Donor',
  avatar: attach_file('daniel.jpg')
})
javier = User.create({
  email: 'javier@email.com',
  password: '123123',
  name: 'Javier',
  user_type: 'Donor',
  avatar: attach_file('javier.jpg')
})
clodulfo = User.create({
  email: 'clodulfo@email.com',
  password: '123123',
  name: 'Clodulfo',
  user_type: 'Donor',
  avatar: attach_file('clodulfo.jpg')
})
pancracio = User.create({
  email: 'pancracio@email.com',
  password: '123123',
  name: 'Pancracio',
  user_type: 'Donor',
  avatar: attach_file('pancracio.jpg')
})

# SocialCompany
aurora = User.create({
  email: 'aurora@email.com',
  password: '123123',
  name: 'Aurora',
  user_type: 'SocialCompany',
  rut: '12345681',
  description: 'Esta es la empresa social aurora. Ni idea que hacen estos chicos',
  address: 'Avenida el bosque con alguna calle de por ahí',
  avatar: attach_file('aurora.jpg')
})
atenea = User.create({
  email: 'atenea@email.com',
  password: '123123',
  name: 'Atenea',
  user_type: 'SocialCompany',
  rut: '12345681',
  description: 'Esta es la empresa social atenea. Algo griego deben hacer ellos, pero la verdad es que es un misterio',
  address: 'Avenida el griego con casas azules',
  avatar: attach_file('atenea.jpg')
})

# Projects
aurora.projects.create({
  name: 'Pulsera inteligente para ciegos',
  description: 'Esta es una pulsera que consiste en ..., se entregará de manera gratuita para los niños ciegos de ...',
  estimated_end_date: Time.now + 2.year
})
aurora.projects.create({
  name: 'Prototipo funcional de brazo mecánico para minusvalidos',
  description: 'Esta es proyecto que consiste en ..., será utilizado por personas con ...',
  estimated_end_date: Time.now + 1.year
})
atenea.projects.create({
  name: 'Viviendas sociales San Lorenzo',
  description: 'Esta es proyecto que consiste en la contrucciones de viviendas sociales en San Lorenzo, un lugar ubicado en ...',
  estimated_end_date: Time.now + 9.months
})

# Offered benefits
cocacola.offered_benefits.create({
    title: "20% de descuento en la bebida de la promo",
    description: "Válido hasta el último día de abril (2019)"
})
cocacola.offered_benefits.create({
    title: "10% de descuento en disfraces de navidad",
    description: "Válido hasta el último día de diciembre (2017)"
})
pepsi.offered_benefits.create({
    title: "80% de descuento en todo lo que le compita a CocaCola",
    description: "Válido hasta siempre"
})
starbucks.offered_benefits.create({
    title: "1% de descuento en frappuccino de frambuesa",
    description: "Válido hasta ayer"
})

# Requirements
Requirement.create(project_id: atenea.projects.first.id, user_id: cocacola.id)
Requirement.create(project_id: atenea.projects.first.id, user_id: pepsi.id)
Requirement.create(project_id: atenea.projects.first.id, user_id: starbucks.id)
Requirement.create(project_id: aurora.projects.first.id, user_id: starbucks.id)
Requirement.create(project_id: aurora.projects.second.id, user_id: pepsi.id)
Requirement.create(project_id: aurora.projects.second.id, user_id: starbucks.id)

# Contracts
Contract.create(project_id: atenea.projects.first.id, benefit_id: cocacola.offered_benefits.first.id)
Contract.create(project_id: atenea.projects.first.id, benefit_id: pepsi.offered_benefits.first.id)
Contract.create(project_id: aurora.projects.first.id, benefit_id: starbucks.offered_benefits.first.id)
Contract.create(project_id: aurora.projects.first.id, benefit_id: cocacola.offered_benefits.second.id)

# Acquired benefits
ab1 = javier.user_benefits.create(benefit_id: cocacola.offered_benefits.first.id)
ab2 = clodulfo.user_benefits.create(benefit_id: cocacola.offered_benefits.first.id)
ab3 = pancracio.user_benefits.create(benefit_id: cocacola.offered_benefits.first.id)

ab4 = javier.user_benefits.create(benefit_id: starbucks.offered_benefits.first.id)
ab5 = clodulfo.user_benefits.create(benefit_id: starbucks.offered_benefits.first.id)
ab6 = pancracio.user_benefits.create(benefit_id: starbucks.offered_benefits.first.id)

ab7 = javier.user_benefits.create(benefit_id: pepsi.offered_benefits.first.id)
ab8 = clodulfo.user_benefits.create(benefit_id: pepsi.offered_benefits.first.id)
ab9 = pancracio.user_benefits.create(benefit_id: pepsi.offered_benefits.first.id)

ab10 = javier.user_benefits.create(benefit_id: cocacola.offered_benefits.last.id)
ab11 = clodulfo.user_benefits.create(benefit_id: cocacola.offered_benefits.last.id)
ab12 = pancracio.user_benefits.create(benefit_id: cocacola.offered_benefits.last.id)

# Donations
d1= cocacola.donations.create({
    project: atenea.projects.first,
    amount: 15423,
})
d2 = cocacola.donations.create({
    project: atenea.projects.first,
    amount: 17942,
})
d3 = cocacola.donations.create({
    project: aurora.projects.second,
    amount: 52651,
})
d4 = pepsi.donations.create({
    project: atenea.projects.first,
    amount: 4938,
})
d5 = pepsi.donations.create({
    project: aurora.projects.first,
    amount: 1242,
})
d6 = starbucks.donations.create({
    project: aurora.projects.first,
    amount: 78645,
})
d7 = starbucks.donations.create({
    project: aurora.projects.first,
    amount: 7333,
})
d8 = starbucks.donations.create({
    project: aurora.projects.second,
    amount: 98721,
})
d9 = starbucks.donations.create({
    project: atenea.projects.first,
    amount: 8721,
})
d10 = romano.donations.create({
    project: atenea.projects.first,
    amount: 721,
})
d11 = daniel.donations.create({
    project: aurora.projects.second,
    amount: 3321,
})
d12 = jorge.donations.create({
    project: aurora.projects.first,
    amount: 3921,
})
d13 = jorge.donations.create({
    project: aurora.projects.second,
    amount: 11121,
})
d14 = domingo.donations.create({
    project: atenea.projects.first,
    amount: 721,
})
d15 = domingo.donations.create({
    project: aurora.projects.first,
    amount: 33721,
})

ab1.update_attribute :created_at, (1).days.ago
ab2.update_attribute :created_at, (2).days.ago
ab3.update_attribute :created_at, (2).days.ago
ab4.update_attribute :created_at, (4).days.ago
ab5.update_attribute :created_at, (2).days.ago
ab6.update_attribute :created_at, (4).days.ago
ab7.update_attribute :created_at, (3).days.ago
ab8.update_attribute :created_at, (1).days.ago
ab9.update_attribute :created_at, (1).days.ago
ab10.update_attribute :created_at, (5).days.ago
ab11.update_attribute :created_at, (5).days.ago
ab12.update_attribute :created_at, (3).days.ago


d1.update_attribute :created_at, (1).days.ago
d2.update_attribute :created_at, (2).days.ago
d3.update_attribute :created_at, (3).days.ago
d4.update_attribute :created_at, (4).days.ago
d5.update_attribute :created_at, (5).days.ago
d6.update_attribute :created_at, (4).days.ago
d7.update_attribute :created_at, (3).days.ago
d8.update_attribute :created_at, (2).days.ago
d9.update_attribute :created_at, (1).days.ago
d10.update_attribute :created_at, (5).days.ago
d11.update_attribute :created_at, (4).days.ago
d12.update_attribute :created_at, (3).days.ago
d13.update_attribute :created_at, (2).days.ago
