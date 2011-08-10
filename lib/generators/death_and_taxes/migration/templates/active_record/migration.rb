class DeathAndTaxesMigration < ActiveRecord::Migration
  def self.up
    create_table :taxations do |t|
      t.references :taxable, :polymorphic => true
      t.integer :amount
      t.float :percentage
      t.string :level
      t.string :name
    end
    
    add_index :taxations, [:taxable_id, :taxable_type]
  end
  
  def self.down
    drop_table :taxations
  end
end