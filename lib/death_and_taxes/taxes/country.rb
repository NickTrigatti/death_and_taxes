class DeathAndTaxes::Taxes::Country
  
  def initialize tax_infos
    @taxes = tax_infos['taxes'].collect do |tax|
      Tax.new tax, :country => self
    end
    
    @states = {}
    tax_infos['states'].each do |name, tax|
      @states[name] = Tax.new(tax)
    end
  end
  
  def apply_taxes product, from, to, options = {}
    if from[:country] == to[:country]
      if (state = @states[from[:state]] && state.matches?(from, to))
        state.apply_taxes product, from, to, options
      else
        apply_tax product, from, to, options
      end
    end
    []
  end
  
  private
  def apply_tax product, from, to, options
    options.reverse_merge!({:time => Time.now})
    
    find_tax product, options[:date]
  end
  
  def find_tax product, date
    @taxes.select do |tax|
      tax.period.cover?(date)
    end
  end
  
end