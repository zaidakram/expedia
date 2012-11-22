# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'expedia/version'

Gem::Specification.new do |gem|
  gem.name          = "expedia"
  gem.version       = Expedia::VERSION
  gem.authors       = ["Zaid Akram"]
  gem.email         = ["zaid.akram@coeus-solutions.de"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

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
