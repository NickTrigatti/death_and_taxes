$:.push File.join(File.dirname(__FILE__), '/lib')

require 'death_and_taxes/version'

Gem::Specification.new do |gem|
  gem.name = "death_and_taxes"
  gem.authors = ['Guillaume Malette']
  gem.date = %q{2011-08-09}
  gem.description = %q{Death and Taxes allows to 'easily' calculate taxes on a model}
  gem.summary = "Tax calculations"
  gem.email = 'gmalette@gmail.com'
  gem.homepage = ''
  
  gem.add_runtime_dependency 'rails'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'rspec'
  
  gem.executables   = []
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
  gem.version       = DeathAndTaxes::VERSION
end
