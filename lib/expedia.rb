# useful tools
require 'digest/md5'
require 'multi_json'

# include expedia modules
require 'expedia/errors'
require 'expedia/api'

# HTTP module so we can communicate with Expedia
require 'expedia/http_service'

# miscellaneous
require 'expedia/utils'
require 'expedia/version'

if defined?(Rails)
  require 'expedia/railtie'
  require 'generators/expedia/initialize_generator'
end

module Expedia

  class << self

    attr_accessor :cid, :api_key, :shared_secret, :format, :locale,
      :currency_code, :minor_rev, :timeout, :open_timeout, :use_signature

    # Default way to setup Expedia. Run generator to create
    # a fresh initializer with all configuration values.
    def setup
      Expedia.use_signature = true #default
      yield self
    end

    def root_path
      Gem::Specification.find_by_name("expedia").gem_dir
    end

  end

end
