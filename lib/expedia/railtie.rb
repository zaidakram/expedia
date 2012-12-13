require 'rails'

module Expedia
  class Railtie < Rails::Railtie

    rake_tasks do
      load "tasks/expedia.rake"
    end

  end
end