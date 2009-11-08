@import <Foundation/CPObject.j>
@import "TerrainItemModel.j"

var TILE_PIXEL_WIDTH = 100;
var TILE_PIXEL_HEIGHT = 100;

@implementation MapModel : CPObject
{
  CPString _name;
  CPNumber _width;
  CPNumber _height;
  CPArray _terrain;
}

- (id)initWithMapModelJSONData:(CPObject)dataJSON
{
  self = [super init];
  
  var dataObject = JSON.parse(dataJSON);
  
  //CPLogConsole("dataObject.unique_terrain[0].image_url: "+JSON.parse(dataObject.unique_terrain), "info", "MapModel");
  
  if (self)
  {
    _name = dataObject.name;
    _width = dataObject.width;
    _height = dataObject.height;
    _terrain = dataObject.flat_terrain;
    
    // Now offload the unique_terrain hash into our TerrainItemResourceManager
    [TerrainItemModel setAvailableTerrainModels:[CPArray arrayWithArray:JSON.parse(dataObject.unique_terrain)]];
    // so our terrainItemModels() accessors can pull from the cache
  }
  
  return self;
}

- (CPArray)terrainItemModels
{
  var terrainItemModels = [];
  // Map the _terrain array to an array of TerrainItemModels of the corresponding id
  for(var index=0;index<_terrain.length;index++)
  {
    //CPLogConsole("terrainItemModels index: "+index+" terrain[index]: "+_terrain[index], "info", "MapModel");
    terrainItemModels.push([TerrainItemModel findById:_terrain[index]]);
  }
  
  return terrainItemModels;
}

- (int)pixelWidth
{
  return _width * TILE_PIXEL_WIDTH;
}

- (int)pixelHeight
{
  return _height * TILE_PIXEL_HEIGHT;
}