module DeathAndTaxes
  class TaxList
    def initialize yml = nil
      parse yml unless yml
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
  end
end