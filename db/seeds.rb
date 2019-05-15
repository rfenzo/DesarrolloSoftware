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

# SocialCompany
aurora = User.create({
  email: 'aurora@email.com',
  password: '123123',
  name: 'Aurora (Empresa social)',
  user_type: 'SocialCompany',
  rut: '12345681',
  description: 'Esta es la empresa social aurora. Ni idea que hacen estos chicos',
  address: 'Avenida el bosque con alguna calle de por ahí',
  avatar: attach_file('aurora.jpg')
})
atenea = User.create({
  email: 'atenea@email.com',
  password: '123123',
  name: 'Atenea (Empresa social)',
  user_type: 'SocialCompany',
  rut: '12345681',
  description: 'Esta es la empresa social atenea. Algo griego deben hacer ellos, pero la verdad es que es un misterio',
  address: 'Avenida el griego con casas azules',
  avatar: attach_file('atenea.jpg')
})

# Projects
aurora.projects.create({
  name: 'Pulsera inteligente para ciegos',
  description: 'Esta es una pulsera que consiste en ..., se entregará de manera gratuita para los niños ciegos de ...'
})
aurora.projects.create({
  name: 'Prototipo funcional de brazo mecánico para minusvalidos',
  description: 'Esta es proyecto que consiste en ..., será utilizado por personas con ...'
})
atenea.projects.create({
  name: 'Viviendas sociales San Lorenzo',
  description: 'Esta es proyecto que consiste en la contrucciones de viviendas sociales en San Lorenzo, un lugar ubicado en ...'
})

# Benefits
cocacola.benefits.create({
    title: "20% de descuento en la bebida de la promo",
    description: "Válido hasta el último día de abril (2019)"
})
cocacola.benefits.create({
    title: "10% de descuento en disfraces de navidad",
    description: "Válido hasta el último día de diciembre (2017)"
})
pepsi.benefits.create({
    title: "80% de descuento en todo lo que le compita a CocaCola",
    description: "Válido hasta siempre"
})
starbucks.benefits.create({
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
Contract.create(project_id: atenea.projects.first.id, benefit_id: cocacola.benefits.first.id)
Contract.create(project_id: atenea.projects.first.id, benefit_id: pepsi.benefits.first.id)
Contract.create(project_id: aurora.projects.first.id, benefit_id: starbucks.benefits.first.id)
Contract.create(project_id: aurora.projects.first.id, benefit_id: cocacola.benefits.second.id)

# Donations
cocacola.donations.create({
    project: atenea.projects.first,
    amount: 15423,
})
cocacola.donations.create({
    project: atenea.projects.first,
    amount: 17942,
})
cocacola.donations.create({
    project: aurora.projects.second,
    amount: 52651,
})
pepsi.donations.create({
    project: atenea.projects.first,
    amount: 4938,
})
pepsi.donations.create({
    project: aurora.projects.first,
    amount: 1242,
})
starbucks.donations.create({
    project: aurora.projects.first,
    amount: 78645,
})
starbucks.donations.create({
    project: aurora.projects.first,
    amount: 7333,
})
starbucks.donations.create({
    project: aurora.projects.second,
    amount: 98721,
})
starbucks.donations.create({
    project: atenea.projects.first,
    amount: 8721,
})
romano.donations.create({
    project: atenea.projects.first,
    amount: 721,
})
daniel.donations.create({
    project: aurora.projects.second,
    amount: 3321,
})
jorge.donations.create({
    project: aurora.projects.first,
    amount: 3921,
})
jorge.donations.create({
    project: aurora.projects.second,
    amount: 11121,
})
domingo.donations.create({
    project: atenea.projects.first,
    amount: 721,
})
domingo.donations.create({
    project: aurora.projects.first,
    amount: 33721,
})
