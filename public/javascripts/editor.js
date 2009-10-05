function TerrainManager(terrain_types) {
  var _terrain_types = terrain_types;
  
  return {
     get_terrain_by_id: function(terrain_id) {
      return $.grep(_terrain_types, function(ter_type) { 
        return ter_type.id == terrain_id; 
      })[0];
    }
  };
}


function Map(terrain_grid) {
  // Private vars
  var _terrain_grid = terrain_grid;
  
  return {
    // Public interface
    terrain: function() {
      return $.map(_terrain_grid, function(terrain_row) {
        return [$.map(terrain_row, function(tid) {
          return _terrain_manager.get_terrain_by_id(tid);
        })];
      });
    }
  };
}