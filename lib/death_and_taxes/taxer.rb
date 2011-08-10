module DeathAndTaxes
  module Taxer
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      ##
      # Makes this model a taxer
      # It will then be able to create and possess taxes
      # Example:
      #   class State < ActiveRecord::Base
      #     acts_as_taxer
      #   end
      def acts_as_taxer(*args)    
        class_eval do
          has_many :taxes, :as => :taxer, :class_name => "DeathAndTaxes::Tax"
        end
      end
    end
  end
end