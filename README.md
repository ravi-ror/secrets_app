# README

Instructions to run rails app:


Rails environment needed:
ruby 2.5.1
rails 5.2.2

1. bundle install

2. rake application:setup 

  OR

Manually run:
	rake db:create
	rake db:migrate
	rake db:seed
	rails s

3. A new "Admin" user is created:
	email = admin@gmail.com
	pass = admin123

4. From navbar menu visit "/users/sign_in" page to login with above credentials

4. Admin can visit "/secrets" path
	 generate new secrets from "/secrets" page

5. Sign out from menu dropdown

6. Register new user with any unassigned secret picked from "/secrets" page. New users will be created with role "User"

7. User is default login after registration. User has no permission to visit "/secrets"  

