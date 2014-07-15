# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'expedia/version'

Gem::Specification.new do |gem|
  gem.name          = "expedia"
  gem.version       = Expedia::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Zaid Akram"]
  gem.email         = ["zaidakrammughal@gmail.com"]
  gem.licenses      = ["MIT"]
  gem.description   = "Expedia is a lightweight, flexible Ruby SDK for EAN. It allows read/write access to the EAN APIs."
  gem.summary       = "Expedia is a ruby wrapper for 'EAN (Expedia Affiliate Network)'"
  gem.homepage      = "https://github.com/zaidakram/expedia"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency(%q<multi_json>,    ["~> 1.3"])
  gem.add_runtime_dependency(%q<faraday>,       ["~> 0.8"])
  gem.add_runtime_dependency(%q<addressable>,   ["~> 2.2"])
  gem.add_development_dependency(%q<rspec>,     ["~> 2.8"])
  gem.add_development_dependency(%q<rake>,      ["~> 0.8"])

  
end
