@import <Foundation/CPObject.j>
@import "TerrainItemModel.j"

var TILE_PIXEL_WIDTH = 100;
var TILE_PIXEL_HEIGHT = 100;

// Default MapModelDataObject
var defaultMapDataJSON = '{  \"name\":\"The Briney Depths\",  \"width\":5,  \"height\":6,  \"terrain\":[1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3],  \"nothing\":\"nothing\" }';

@implementation MapModel : CPObject
{
  CPString _name;
  CPNumber _width;
  CPNumber _height;
  CPArray _terrain;
}

+ (id)findById:(int)uid
{
  return [[MapModel alloc] initWithMapModelDataJSON:defaultMapDataJSON];
}

- (id)initWithMapModelJSONData:(CPObject)dataJSON
{
  self = [super init];
  
  var dataObject = JSON.parse(dataJSON);
  
  if (self)
  {
    _name = dataObject.name;
    _width = dataObject.width;
    _height = dataObject.height;
    _terrain = dataObject.flat_terrain;
    
    // Now offload the unique_terrain hash into our TerrainItemResourceManager
    [TerrainItemModel setAvailableTerrainModels:[CPArray arrayWithArray:dataObject.unique_terrain]];
    // so our terrainItemModels() accessors can pull from the cache
  }
  
  return self;
}

- (CPArray)terrainItemModels
{
  var terrainItemModels = [];
  // Map the _terrain array to an array of TerrainItemModels of the corresponding id
  for (terrainItemId in _terrain)
  {
    terrainItemModels.push([TerrainItemModel findById:terrainItemId]);
  }
  
  return [CPArray arrayWithArray:terrainItemModels];
}

- (int)pixelWidth
{
  return _width * TILE_PIXEL_WIDTH;
}

- (int)pixelHeight
{
  return _height * TILE_PIXEL_HEIGHT;
}