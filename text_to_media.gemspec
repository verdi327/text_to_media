# -*- encoding: utf-8 -*-
require File.expand_path('../lib/text_to_media/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["michael verdi"]
  gem.email         = ["michael.v.verdi@gmail.com"]
  gem.description   = %q{Parses text for valid url then returns html to embed content}
  gem.summary       = %q{Parses text for valid url then returns html to embed content}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "text_to_media"
  gem.require_paths = ["lib"]
  gem.version       = TextToMedia::VERSION

  gem.add_development_dependency("rspec")
  gem.add_runtime_dependency("embedly")
end
