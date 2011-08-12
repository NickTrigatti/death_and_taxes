module DeathAndTaxes
  class Country
    @taxes = {}
    @states = {}
    
    def initialize code, yml = nil
      @code = code
      parse yml if yml
    end
    
    def parse yml
      yml['taxes'].each do |tax_name, versions|
        @taxes[tax_name] = VersionTax.new(versions)
      end
      
      yml['states'].each do |state_code, state_yml|
        @states[state_code] = State.new(state_code, state_yml)
      end
    end
    
    def applies_taxes? from_state, to_state, date
      return false unless @states[from_state] && @states[to_state]
      
      @states[from_state].applies_taxes? to_state, date
    end
  end
end