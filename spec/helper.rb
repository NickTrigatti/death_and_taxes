require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'death_and_taxes'


def applicable_taxes from, to, date = nil
  defaults = {:country => "ca", :state => "qc"}
  from = defaults.merge from
  to = defaults.merge to
  DeathAndTaxes.applicable_taxes from, to, date
end