class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.string :name
      t.integer :width
      t.integer :height
      t.text :terrain
      t.boolean :published, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :maps
  end
end
