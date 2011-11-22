module DeathAndTaxes
  class State
    
    def initialize code, yml = nil
      @taxes = {}
      @code = code
      parse yml if yml
    end
    
    def parse yml
      ##
      # Builds a tax list for each taxes defined in this state
      yml['taxes'].each do |tax_name, infos|
        @taxes[tax_name] = TaxInfo.new(tax_name, infos)
      end

      @rules = yml['rules']
    end
    
    def applicable_taxes to_state, date
      rule = @rules.select{|d| (d['starts']..d['ends']).cover? date}.first
      taxes = if to_state == @code && rule['same_state']
        rule['same_state']
      elsif rule['same_country']
        rule['same_country']
      else
        []
      end
      [taxes].flatten
    end
    
    def build_tax tax, date
      if (i = @taxes[tax]) && i.cover?(date)
        i.build(date)
      end
    end
  end
end