require 'active_record'
require 'active_record/version'

require 'active_support/core_ext'


require File.join(File.dirname(__FILE__), 'death_and_taxes/railtie')

module DeathAndTaxes
  autoload :Hook,            File.join(File.dirname(__FILE__), "death_and_taxes/hook")
  autoload :InstanceMethods, File.join(File.dirname(__FILE__), "death_and_taxes/instance_methods")
  
  @taxes = Dir[File.join( File.dirname(__FILE__), '..', 'config', '*.yml' )].map do |filename|
    DeathAndTaxes::Taxes::Country.new(YAML.load_file(file_name))
  end
end