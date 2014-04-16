require "colorize"

namespace :expedia do

	desc "It creates an Expedia initializer"
	task :initialize do
    puts "EXPEDIA: [Deprecation warning] 'rake expedia:initialize' is deprecated and will be removed in a future version; please use 'rails g expedia:initialize' instead."
		# Copy the template to the applicaion's initializers folder.
		cp "#{Expedia.root_path}/lib/generators/templates/expedia.txt", "config/initializers/expedia.rb"
		# Shashka: Colorize output.
		puts "#{'create: '.colorize(:green)} config/initializers/expedia.rb"
	end

end