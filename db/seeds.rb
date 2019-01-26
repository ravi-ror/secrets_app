# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "*** Seeding started ***"

email = 'admin@gmail.com'
pass =  'admin123'
begin
	secret = Secret.create!(encrypted_secret: pass)
	admin_user = User.new( email: email, first: 'Super', last: 'Admin')
  admin_user.secret = secret
	admin_user.save!
	admin_user.add_role "admin"	
	puts "Created admin user# Email: #{email} Password: #{pass}"
rescue => e
	puts "Error createing user:", e
end

puts "*** Seeding done ***"
