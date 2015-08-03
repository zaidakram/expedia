Expedia.setup do |config|
  config.cid = 55505 # your cid once you go live.
  config.api_key = 'your_api_key'
  config.shared_secret = 'your_shared_secret'
  config.locale = 'en_US' # For Example 'de_DE'. Default is 'en_US'
  config.currency_code = 'USD' # For Example 'EUR'. Default is 'USD'
  config.minor_rev = 28 # between 4-28 as of Jan 2015. If not set, 4 is used by EAN.
  config.use_signature = true # An encoded signature is not required if ip whitelisting is used
  # optional configurations...
  config.timeout = 1 # read timeout in sec
  config.open_timeout = 1 # connection timeout in sec
end
