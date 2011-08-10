module DeathAndTaxes
  module Taxable
    def self.included(base)
      base.extend ClassMethods
    end
    
    
    module ClassMehtods
      
      ##
      # Makes this model taxable
      # It will then be able to have taxations applied
      # Example:
      #   class Invoicing < ActiveRecord::Base
      #     acts_as_taxable
      #   end
      def acts_as_taxable(*args)    
        class_eval do
          has_many :taxations, :polymorphic => true, :class_name => 'DeathAndTaxes::Taxation'
        end
      end
    end
  end
end