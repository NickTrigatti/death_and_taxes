module DeathAndTaxes::Taxable
  has_many :taxations, :polymorphic => true
  
end