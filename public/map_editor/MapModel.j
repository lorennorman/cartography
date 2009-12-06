@import <Foundation/CPObject.j>
@import "TerrainItemModel.j"

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

- (CPArray)terrainItemRows
{
  // Map our flat terrain array to 2D array
  var terrainItemRows = [];
  // Iterate on the vertical axis first because we're adding rows
  for(var yCoord = 0; yCoord < _height; yCoord++)
  {
    var tiRow = [];
    // Now iterate down the row and build it up
    for(var xCoord = 0; xCoord < _width; xCoord++)
    {
      tiRow.push([TerrainItemModel findById:_terrain[yCoord*_width + xCoord]]);
    }
    terrainItemRows.push(tiRow);
  }
  
  return terrainItemRows;
}

- (int)width
{
  return _width;
}

- (int)height
{
  return _height;
}