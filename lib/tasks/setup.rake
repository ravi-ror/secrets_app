require 'bundler'

namespace :application do
  desc "Create and populate db"
  task setup: :environment do 
		puts "*** Starting application setup ***"
		begin
			Rake::Task["db:drop"].invoke
			puts "*** Creating database ***"
		  Rake::Task["db:create"].invoke
			puts "*** Running migrations ***"
			Rake::Task["db:migrate"].invoke
			puts "*** Seeding database ***"
			Rake::Task["db:seed"].invoke
			puts "*** Application setup complete ***"
			Process.exec("rails s")
		rescue
			puts "******  FAILED TO RUN TASKS ******"
			puts "Please run them manually"
		end
  end
end
