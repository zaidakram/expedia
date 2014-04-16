require 'rails/generators'

module Expedia
  class InitializeGenerator < Rails::Generators::Base

    source_root File.expand_path("../../templates", __FILE__)

    def copy_initializer_file
      copy_file "expedia.txt", "config/initializers/expedia.rb"
    end

  end
end