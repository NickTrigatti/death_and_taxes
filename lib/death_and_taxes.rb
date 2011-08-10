require 'active_record'
require 'active_record/version'

require 'active_support/core_ext'


require File.join(File.dirname(__FILE__), 'death_and_taxes/railtie')

module DeathAndTaxes
  autoload :Hook,            File.join(File.dirname(__FILE__), "death_and_taxes/hook")
  autoload :InstanceMethods, File.join(File.dirname(__FILE__), "death_and_taxes/instance_methods")  
end