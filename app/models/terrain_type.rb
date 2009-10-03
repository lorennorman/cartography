class TerrainType < ActiveRecord::Base
  has_attached_file :image, :styles => { :full => "100x100", :icon => "25x25" }
  
  validates_presence_of :name
  validates_attachment_presence :image
end
