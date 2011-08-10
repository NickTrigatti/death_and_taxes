module DeathAndTaxes::Hook
  def acts_as_taxable(*args)
    options = args.extract_options!
    
    include DeathAndTaxes::InstanceMethods
  end
end