module DeathAndTaxes
  class TaxVersion
    def initialize yml
      @start = Date.new(yml['start'])
      @end = Date.new(yml['end'])
    end
    
    def cover? date
      (@start..@end).cover? date
    end
    
    def build
      
    end
  end
end