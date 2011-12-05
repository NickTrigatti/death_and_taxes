require 'rubygems'
require 'bundler'
require 'active_record'
require 'active_support'
require 'rake'
require 'sqlite3'


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
require 'generators/death_and_taxes/migration/templates/active_record/migration'

db_file = File.join(File.dirname(__FILE__), "death_and_taxes.sqlite3")

File.delete db_file if File.exists? db_file

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => db_file
)


RSpec.configure do |config|
end

ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'products'")
ActiveRecord::Base.connection.create_table(:products) do |t|
  t.string :name
  t.integer :amount
end

DeathAndTaxesMigration.up

class Product < ActiveRecord::Base
  acts_as_taxable
end

def applicable_taxes from, to, date = nil
  defaults = {:country => "ca", :state => "qc"}
  from = defaults.merge from
  to = defaults.merge to
  DeathAndTaxes.applicable_taxes from, to, date
end
