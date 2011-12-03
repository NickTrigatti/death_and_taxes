module DeathAndTaxes
  module Taxable
    def self.included(base)
      base.extend ClassMethods
    end
    
    
    module ClassMethods
      
      ##
      # Makes this model taxable
      # It will then be able to have taxations applied
      # Example:
      #   class Invoicing < ActiveRecord::Base
      #     acts_as_taxable
      #   end
      def acts_as_taxable(*args)
        
        class_eval do
          has_many :taxations, :as => :taxable, :class_name => 'DeathAndTaxes::Taxation'
        end
        
        include DeathAndTaxes::Taxable::InstanceMethods
      end
      
      def calculate_rate taxes
        taxes.reduce(1) { |rate, tax| rate + tax.apply(1) }
      end
      
    end
    
    module InstanceMethods
      def apply_taxes(taxes)
        taxes = [taxes] unless taxes.is_a? Array
        
        self.taxations = taxes.collect do |tax|
          Taxation.new :amount => tax.apply(amount).round, :percentage => tax.percentage, :name => tax.name, :account_number => tax.account_number
        end
      end
    end
  end
end