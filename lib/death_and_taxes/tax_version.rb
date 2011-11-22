module DeathAndTaxes
  class TaxVersion
    attr_reader :starts, :ends, :percentage, :apply_on
    def initialize yml
      @starts = yml['starts']
      @ends = yml['ends']
      @percentage = yml['percentage']
      @apply_on = yml['apply_on']
    end
    
    def cover? date
      (@starts..@ends).cover? date
    end
  end
end