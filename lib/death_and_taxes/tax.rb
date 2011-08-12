module DeathAndTaxes
  class Tax < ::ActiveRecord::Base
    belongs_to :taxer, :polymorphic => true
    belongs_to :tax, :foreign_key => :apply_on_tax
    
    validates :percentage, :numericality => {:greater_than => 0.01, :less_than => 100}, :format => /^\d+??(?:\.\d*)?$/, :presence => true
    validates_presence_of :name
    
    def apply amount
      amount * multiplier
    end
    
    def multiplier
      (percentage / 100) * (1 + tax.try(:multiplier).to_f)
    end
    
    def blank?
      percentage.blank? && name.blank? && account_number.blank?
    end
  end
end