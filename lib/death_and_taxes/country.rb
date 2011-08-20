module DeathAndTaxes
  class Country
    
    def initialize code, yml = nil
      @taxes = {}
      @states = {}
      @code = code
      parse yml if yml
    end
    
    def parse yml
      yml['taxes'].each do |tax_name, infos|
        @taxes[tax_name] = TaxInfo.new(tax_name, infos)
      end
      
      yml['states'].each do |state_code, state_yml|
        @states[state_code] = State.new(state_code, state_yml)
      end
    end
    
    def applicable_taxes from, to, date
      if from[:country] == to[:country] && to[:country] == @code
        @states[from[:state]].applicable_taxes to[:state], date
      else
        []
      end
    end
    
    def applies_taxes? from, to, date
      applicable_taxes(from, to, date).any?
    end
    
    def build_tax tax, date
      @taxes[tax].try(:build, date) || @states.detect{|t, s| s.try(:build_tax, tax, date)}.try(:last).try(:build_tax, tax, date)
    end
  end
end