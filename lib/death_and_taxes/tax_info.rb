module DeathAndTaxes
  class TaxInfo
    def initialize name, yml = nil
      @name = name
      parse yml if yml
    end
    
    def parse yml
      @versions = yml['versions'].collect do |version|
        TaxVersion.new(version)
      end
    end
    
    def cover? date
      @versions.any?{ |v| v.cover? date }
    end
    
    def build date
      if v = @versions.detect{ |version| version.cover?(date) }
        t = Tax.new :name => @name, :percentage => v.percentage
        t.tax = DeathAndTaxes.build(v.apply_on, date) if v.apply_on
        t
      end
    end
  end
end