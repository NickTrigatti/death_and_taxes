require 'active_record'
require 'active_record/version'

require 'active_support/core_ext'


require File.join(File.dirname(__FILE__), 'death_and_taxes/railtie')

module DeathAndTaxes
  %w( Tax Taxable Taxation Taxer ).each do |class_name|
    autoload class_name.to_sym, File.join(File.dirname(__FILE__), "death_and_taxes/#{class_name.downcase}")
  end
end