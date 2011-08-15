module DeathAndTaxes
  class TaxVersion
    def initialize yml
      @start = yml['start']
      @end = yml['end']
      @percentage = yml['percentage']
    end
    
    def cover? date
      (@start..@end).cover? date
    end
    
    def build
      
    end
  end
end