module DeathAndTaxes
  class Tax < ::ActiveRecord::Base
    belongs_to :taxer, :polymorphic => true
    belongs_to :tax, :foreign_key => :apply_on_tax
    
    def apply amount
      amount * multiplier
    end
    
    def multiplier
      (percentage / 100) * (1 + tax.try(:multiplier).to_f)
    end
  end
end