class Map < ActiveRecord::Base
  
  serialize :terrain, Array
  
  ###############
  ### Filters ###
  ###############
  
  before_create :initialize_terrain
  
  def initialize_terrain
    # The default terrain type to clear to
    default_id = TerrainType.first.id
    map_column = []
    
    # Create a column of the clear terrain
    self.width.times do
      map_column << default_id
    end
    
    # Copy our basic column for every row
    map_rows = []
    self.height.times do
      map_rows << map_column.clone
    end
    
    self.terrain = map_rows
  end
  
  ###################
  ### Validations ###
  ###################
  
  validates_presence_of :name, :width, :height
  
  ##########################
  ### Virtual Attributes ###
  ##########################
  
  def dimensions
    "#{self.width}x#{self.height}"
  end
  
  def terrain_tiles
    self.terrain.map do |terrain_column|
      terrain_column.map do |terrain_id|
        TerrainType.find(terrain_id)
      end
    end
  end
  
  def unique_terrain
    unique_ids = self.terrain.flatten.uniq
    unique_ids.map do |terrain_type_id|
      TerrainType.find(terrain_type_id)
    end.to_json(:only => [:id, :name], :methods => :image_url)
  end
  
  def flat_terrain
    self.terrain.flatten
  end
end
