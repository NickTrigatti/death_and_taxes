module DeathAndTaxes
  class Tax < ::ActiveRecord::Base
    belongs_to :taxer, :polymorphic => true
  end
end