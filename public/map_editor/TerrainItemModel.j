@import <Foundation/CPObject.j>

var AvailableTerrainModels = [CPArray alloc];

@implementation TerrainItemModel : CPObject
{
  CPNumber _id;
  CPString _name;
  CPString _image_url;
}

+ (id)findById:(int)uid
{
  return [AvailableTerrainModels valueForKey:uid];
}

+ (void)setAvailableTerrainModels:(CPArray)terrainModelArray
{  
  for (terrainItemModelObject in terrainModelArray)
  {
    [AvailableTerrainModels setValue:[[TerrainItemModel alloc] initWithTerrainItemModelDataObject:terrainItemModelObject] forKey:terrainItemModelObject.id];
  }
}

- (id)initWithTerrainItemModelDataJSON:(CPObject)dataJSON
{
  var dataObject = JSON.parse(dataJSON);
  
  [self initWithTerrainItemModelDataObject:dataObject];
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