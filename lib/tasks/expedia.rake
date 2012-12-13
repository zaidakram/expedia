require "colorize"

namespace :expedia do

	desc "It creates an Expedia initializer"
	task :initialize do
		# Copy the template to the applicaion's initializers folder.
		cp "#{Expedia.root_path}/lib/templates/expedia.txt", "config/initializers/expedia.rb"
		# Shashka: Colorize output.
		puts "#{'create: '.colorize(:green)} config/initializers/expedia.rb"
	end

end