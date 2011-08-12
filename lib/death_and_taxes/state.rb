module DeathAndTaxes
  class State
    @taxes = {}
    
    def initialize code, yml = nil
      @code = code
      parse yml if yml
    end
    
    def parse yml
      yml['taxes'].each do |tax_name, versions|
        @taxes[tax_name] = TaxList.new(versions)
      end
      
      @rule = yml['rules']
    end
    
    def applies_taxes? to_state, date
      if to_state == @code && (taxes = @taxes.detect{|tl| tl.cover?(date)})
        taxes.build(t)
      end
    end
  end
end