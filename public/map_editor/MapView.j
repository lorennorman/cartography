@import <AppKit/CPScrollView.j>
@import "MapModel.j"
@import "TerrainItemView.j"

@implementation MapView : CPCollectionView
{
}

- (id)init
{
  self = [super initWithFrame:CGRectMakeZero()];
  
  if (self)
  {
    [self setBackgroundColor:[CPColor blackColor]];
    [self setAutoresizingMask:nil];
    [self setVerticalMargin:0];
    [self setMinItemSize:CGSizeMake(100, 100)];
    [self setMaxItemSize:CGSizeMake(100, 100)];
    
    // Set up the CollectionView to use TerrainItemViews as children
    var terrainItemPrototype = [[CPCollectionViewItem alloc] init],
        terrainItemView = [[TerrainItemView alloc] initWithFrame:CGRectMakeZero()];
    [terrainItemPrototype setView:terrainItemView];
    [self setItemPrototype:terrainItemPrototype];
  }
  
  return self;
}

- (void)setMapModel:(MapModel)aMapModel
{
  // Calculate the width and height of this map in pixels based on the tile width and height
  var terrainViewBounds = CGRectMake(0,0,[aMapModel pixelWidth], [aMapModel pixelHeight]);
  [self setBounds:terrainViewBounds];
  [self setMaxNumberOfColumns:[aMapModel width]];
  [self setMaxNumberOfRows:[aMapModel height]];
  
  [self setContent:[aMapModel terrainItemModels]];
}
