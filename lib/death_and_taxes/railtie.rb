require 'rails'
require 'death_and_taxes'

module DeathAndTaxes
  class Railtie < Rails::Railtie
    config.to_prepare do
      ActiveRecord::Base.send(:extend, DeathAndTaxes::Hook)
    end
  end
end