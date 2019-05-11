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
User.create({
  email: 'cocacola@email.com',
  password: '123123',
  name: 'Coca Cola',
  user_type: 'Company',
  rut: '12345678',
  description: 'Esta es la compañía cocacola. Así es, la famosa Coca Cola',
  address: 'Avenida polo norte con oso polar',
  avatar: attach_file('cocacola.jpg')
})
User.create({
  email: 'pepsi@email.com',
  password: '123123',
  name: 'Pepsi',
  user_type: 'Company',
  rut: '12345679',
  description: 'Esta es la compañía pepsi. Así es, la copia de Coca Cola',
  address: 'Avenida polo sur con oso normal',
  avatar: attach_file('pepsi.png')
})
User.create({
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
User.create({
  email: 'romano@email.com',
  password: '123123',
  name: 'Romano',
  user_type: 'Donor',
  avatar: attach_file('romano.jpg')
})
User.create({
  email: 'jorge@email.com',
  password: '123123',
  name: 'Jorge',
  user_type: 'Donor',
  avatar: attach_file('jorge.jpg')
})
User.create({
  email: 'domingo@email.com',
  password: '123123',
  name: 'Domnigo',
  user_type: 'Donor',
  avatar: attach_file('domingo.jpg')
})
User.create({
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
