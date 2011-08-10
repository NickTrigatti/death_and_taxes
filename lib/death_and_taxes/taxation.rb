module DeathAndTaxes
  class Taxation < ActiveRecord::Base
    belongs_to :taxable, :polymorphic => true
  end
end