@import <AppKit/CPView.j>

var SelectedTerrainItemModel = nil;

@implementation TerrainItemView : CPView
{
  CPImageView _imageView;
  TerrainItemModel _terrainItemModel;
}

+ (void)setSelectedObject:(TerrainItemModel)aTerrainItemModel
{
  SelectedTerrainItemModel = aTerrainItemModel;
}

// The data object has 3 elements:
//  id: database id
//  name: string representing the name of the terrain
//  image_url: string with the image path on the server
- (void)setRepresentedObject:(id)terrainItemModel
{
  _terrainItemModel = terrainItemModel;
  
  // Initialize our image if needed
  if(!_imageView)
  {
    _imageView = [[CPImageView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    [_imageView setImageScaling:CPScaleProportionally];
    
    [self addSubview:_imageView];
  }
  
  // Create a new image to add to our ImageView
  var newImage = [[CPImage alloc] initWithContentsOfFile:[_terrainItemModel image_url] size:CGSizeMake(100.0,100.0)];
  [_imageView setImage:newImage];
}

- (void)setSelected:(BOOL)isSelected 
{ 
  //[self setBackgroundColor:isSelected ? [CPColor yellowColor] : nil]; 
}


- (void)mouseDown:(CPEvent)theEvent
{
  [self setRepresentedObject:SelectedTerrainItemModel];
}

@end