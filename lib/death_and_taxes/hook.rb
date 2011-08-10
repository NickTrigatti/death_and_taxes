module DeathAndTaxes::Hook
  def acts_as_taxable(*args)
    options = args.extract_options!
    
    include DeathAndTaxes::Taxable
  end
  
  def acts_as_merchant(*args)
    options = args.extract_options!
    
    include DeathAndTaxes::Merchant
  end
end