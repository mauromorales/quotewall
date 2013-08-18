# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quotewall/version'

Gem::Specification.new do |spec|
  spec.name          = "quotewall"
  spec.version       = Quotewall::VERSION
  spec.authors       = ["Mauro Morales"]
  spec.email         = ["contact@mauromorales.com"]
  spec.description   = "Generate a beautiful wallpaper from a specified quote"
  spec.summary       = "Generate a beautiful wallpaper from a specified quote"
  spec.homepage      = "https://github.com/mauromorales/quotewall"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rmagick"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
