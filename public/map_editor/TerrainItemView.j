@import <AppKit/CPView.j>

@implementation TerrainItemView : CPView
{
  CPImageView _imageView;
}

// The data object has 3 elements:
//  id: database id
//  name: string representing the name of the terrain
//  image_url: string with the image path on the server
- (void)setRepresentedObject:(id)terrainItemModel
{
  // Initialize our image if needed
  if(!_imageView)
  {
    _imageView = [[CPImageView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    [_imageView setImageScaling:CPScaleProportionally];
    
    [self addSubview:_imageView];
  }
  
  // Create a new image to add to our ImageView
  var newImage = [[CPImage alloc] initWithContentsOfFile:[terrainItemModel image_url] size:CGSizeMake(100.0,100.0)];
  [_imageView setImage:newImage];
}

- (void)setSelected:(BOOL)isSelected 
{ 
  //[self setBackgroundColor:isSelected ? [CPColor yellowColor] : nil]; 
} 

@end