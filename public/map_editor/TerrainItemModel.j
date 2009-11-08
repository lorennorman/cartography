@import <Foundation/CPObject.j>

var AvailableTerrainModels = [CPArray alloc];

@implementation TerrainItemModel : CPObject
{
  CPNumber _id;
  CPString _name;
  CPString _image_url;
}

+ (id)findById:(CPString)uid
{
  return AvailableTerrainModels[uid];
}

+ (void)setAvailableTerrainModels:(CPArray)terrainModelArray
{  
  //CPLogConsole("setAvailableTerrainModels: entering", "info", "TerrainItemModel");
  
  for(var index=0;index<terrainModelArray.length;index++)
  {
    //CPLogConsole("setAvaialbeTerrainModels iteration: "+terrainModelArray[index], "info", "TerrainItemModel");
    var modelObject = terrainModelArray[index];
    AvailableTerrainModels[modelObject.id] = [[TerrainItemModel alloc] initWithTerrainItemModelDataObject:modelObject];
  }
  //CPLogConsole("setAvailableTerrainModels: exiting", "info", "TerrainItemModel");
}

- (id)initWithTerrainItemModelDataObject:(CPObject)dataObject
{
  self = [super init];
  
  if (self)
  {
    _id = dataObject.id;
    _name = dataObject.name;
    _image_url = dataObject.image_url;
  }
  
  return self;
}

- (CPString)image_url
{
  return _image_url;
}

@end