class TerrainType < ActiveRecord::Base
  has_attached_file :image, :styles => { :full => "100x100", :icon => "25x25" }
  
  validates_presence_of :name
  validates_attachment_presence :image
  
  def self.all_for_editor
    TerrainType.all(:order => :id).map do |terrain_type|
      {
        :id => terrain_type.id,
        :name => terrain_type.name,
        :icon_url => terrain_type.image.url(:icon),
        :full_url => terrain_type.image.url(:full)
      }
    end
  end
  
  def image_url
    self.image.url(:full)
  end
end
