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
    end
    
    module InstanceMethods
      def apply_taxes(taxes)
        taxes.each do |tax|
          
          tax.apply(amount)
        end
      end
    end
  end
end