module DeathAndTaxes
  class State
    @taxes = {}
    
    def initialize code, yml = nil
      @code = code
      parse yml if yml
    end
    
    def parse yml
      ##
      # Builds a tax list for each taxes defined in this state
      yml['taxes'].each do |tax_name, infos|
        @taxes[tax_name] = TaxInfo.new(tax_name, infos)
      end
      
      @rule = yml['rules']
    end
    
    def applicable_taxes to_state, date
      taxes = if to_state == @code && @rules['same_state']
        @rules['same_state']
      elsif @rules['same_country']
        @rules['same_country']
      else
        []
      end
      [taxes].flatten.select{|t| t.cover?(date)}
    end
    
    def build_tax tax, date
      if i = @taxes[tax] && i.cover?(date)
        i.build(date)
      end
    end
  end
end