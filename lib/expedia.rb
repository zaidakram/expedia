# useful tools
require 'digest/md5'
require 'multi_json'

# include koala modules
require 'expedia/errors'


# HTTP module so we can communicate with Expedia
require 'expedia/http_service'

# miscellaneous
require 'expedia/utils'
require 'expedia/version'

module Expedia

	mattr_accessor :cid, :api_key, :shared_secret, :format, :locale,
		:currency_code

	# Default way to setup Devise. Run generator to create
	# a fresh initializer with all configuration values.
	def self.setup
	  yield self
	end
	
end
