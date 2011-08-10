class DeathAndTaxesMigration < ActiveRecord::Migration
  def self.up
    create_table :taxations do |t|
      t.references :taxable, :polymorphic => true
      t.integer :amount
      t.float :percentage
      t.string :name
      
      t.timestamps
    end
    
    create_table :taxes do |t|
      t.references :taxer, :polymorphic => true
      t.float :percentage
      t.string :name
      t.string :account_number
      t.integer :apply_on_tax
      
      t.timestamps
    end
    
    add_index :taxations, [:taxable_id, :taxable_type]
    add_index :taxes, [:taxer_id, :taxer_type]
    add_index :taxes, :apply_on_tax
  end
  
  def self.down
    drop_table :taxations
    drop_table :taxes
  end
end