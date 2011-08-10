require 'rails/generators/active_record'
require 'rails/generators/migration'

# Blindly copied from acts-as-taggable-on
module DeathAndTaxes
  class MigrationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    
    desc "Generates migrations for taxations"
    
    def self.orm
      Rails::Generators.options[:rails][:orm]
    end
    
    def self.source_root
      File.join(File.dirname(__FILE__), 'templates', (orm.to_s unless orm.class.eql?(String)))
    end
    
    def self.orm_has_migration?
      [:active_record].include? orm
    end
    
    def self.next_migration_number path
      ActiveRecord::Generators::Base.next_migration_number path
    end
    
    def create_migration_file
      if self.class.orm_has_migration?
        migration_template 'migration.rb', 'db/migrate/death_and_taxes_migration'
      end
    end
  end
end