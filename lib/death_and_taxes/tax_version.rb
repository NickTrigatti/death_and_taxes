module DeathAndTaxes
  class TaxVersion
    attr_reader :starts, :ends, :percentage
    def initialize yml
      @starts = yml['starts']
      @ends = yml['ends']
      @percentage = yml['percentage']
    end
    
    def cover? date
      (@starts..@ends).cover? date
    end
  end
end