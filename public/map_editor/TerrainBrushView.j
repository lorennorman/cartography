@import <AppKit/CPView.j>

@implementation TerrainBrushView : CPView
{
  CPImageView _imageView;
  CPTextField _labelView;
  TerrainItemModel _representedTerrainItemModel;
}

// The data object has 3 elements:
//  id: database id
//  name: string representing the name of the terrain
//  image_url: string with the image path on the server
- (void)setRepresentedObject:(id)anObject
{
  _representedTerrainItemModel = anObject;
  
  // Initialize our label if needed
  if(!_labelView)
  {
    var frame = CGRectMake(0,100,100,20);
    
    _labelView = [[CPTextField alloc] initWithFrame:frame];
    [_labelView setEditable:NO];
    [_labelView setTextColor:[CPColor grayColor]];
    [_labelView setAutoresizingMask:CPViewMaxXMargin]
    
    [self addSubview:_labelView];
  }
  
  // Update the label text with the name
  [_labelView setStringValue:[_representedTerrainItemModel name]];
  [_labelView sizeToFit];
  
  // Initialize our image if needed
  if(!_imageView)
  {
    var frame = CGRectInset([self bounds], 5, 5);
    frame.size.height -= 20;
    _imageView = [[CPImageView alloc] initWithFrame:frame];
    [_imageView setImageScaling:CPScaleProportionally];
    [_imageView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    
    [self addSubview:_imageView];
  }
  
  // Create a new image to add to our ImageView
  var newImage = [[CPImage alloc] initWithContentsOfFile:[_representedTerrainItemModel image_url] size:CGSizeMake(100.0,100.0)];
  [_imageView setImage:newImage];
}

- (void)setSelected:(BOOL)isSelected 
{ 
  [self setBackgroundColor:isSelected ? [CPColor yellowColor] : nil];
  [TerrainItemView setSelectedObject:_representedTerrainItemModel];
} 

@end 