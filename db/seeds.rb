# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w[operations sales marketing risk management finance hr development data].each do |name|
  Department.find_or_create_by(name: name)
end


%w[admin employee].each do |name|
  Role.find_or_create_by(name: name)
end

admin = User.create(first_name: 'Admin', last_name: 'Admin', email: 'admin@creditshelf.com', password: '12345678')
admin.add_role :admin

(1..50).to_a.each do |name|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{first_name.downcase}.#{last_name.downcase}@creditshelf.com"
  user = User.create(first_name: first_name, last_name: last_name , email: email, password: '12345678', department_id: Department.pluck(:id).sample)
  user.add_role :employee
  user.manage_mystery_group
end





