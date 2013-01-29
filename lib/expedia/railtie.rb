require 'rails'

module Expedia
  class Railtie < Rails::Railtie

    # Load rake tasks
    rake_tasks do
      load "tasks/expedia.rake"
    end

  end
end
