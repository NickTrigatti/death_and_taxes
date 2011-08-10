class DeathAndTaxes::Tax
  belongs_to :taxer, :polymorphic => true
end