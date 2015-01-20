# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spectra/version'

Gem::Specification.new do |gem|
  gem.name          = 'spectra'
  gem.version       = Spectra::VERSION
  gem.authors       = ['Ty Cobb']
  gem.email         = ['ty.cobb.m@gmail.com']
  gem.summary       = %q{DSL for synchronizng color palettes, Objective-C categories, and Swift extensions}
  gem.description   = %q{DSL for synchronzing color palettes, Objective-C categories, and Swift extensions}
  gem.homepage      = 'https://github.com/derkis/Spectrum'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = ['spectra']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.6'
  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'pry', '~> 0.10'
  gem.add_development_dependency 'pry-byebug', '~> 2.0'

  gem.add_runtime_dependency 'claide', '~> 0.8'
  gem.add_runtime_dependency 'mustache', '~> 1.0'
end

