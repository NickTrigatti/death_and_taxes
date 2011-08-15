module DeathAndTaxes
  class TaxInfo
    def initialize name, yml = nil
      @name = name
      parse yml if yml
    end
    
    def parse yml
      @apply_on = yml['apply_on']
      @versions = yml['versions'].collect do |version|
        TaxVersion.new(version)
      end
    end
    
    def cover? date
      @versions.any?{ |version| v.cover? date }
    end
    
    def build date
      if v = @versions.detect{ |v| v.cover?(date) }
        t = Tax.new :name => @name, :percentage => v['percentage']
        t.tax = DeathAndTaxes.build_tax(@apply_on, date) if @apply_on
        t
      end
    end
  end
end