require "colorize"

namespace :expedia do

	desc "It creates an Expedia initializer"
	task :initialize do
		cp "#{Expedia.root_path}/lib/templates/expedia.txt", "config/initializers/expedia.rb"
		puts "#{'create: '.colorize(:green)} config/initializers/expedia.rb"
	end

end