@import <AppKit/CPScrollView.j>
@import "MapModel.j"
@import "TerrainItemView.j"

@implementation MapView : CPScrollView
{
  CPCollectionView _terrainView;
}

- (id)initWithFrame:(CPRect)aRect
{
  self = [super initWithFrame:aRect];
  
  if (self)
  {
    // Create and configure the CPCollectionView that will display our beautiful map
    _terrainView = [[CPCollectionView alloc] initWithFrame:CGRectMakeZero()];
    [_terrainView setBackgroundColor:[CPColor blackColor]];
    [_terrainView setAutoresizingMask:nil];
    [_terrainView setVerticalMargin:0];
    [_terrainView setMinItemSize:CGSizeMake(100, 100)];
    [_terrainView setMaxItemSize:CGSizeMake(100, 100)];
    
    // Set up the CollectionView to use TerrainItemViews as children
    var terrainItemPrototype = [[CPCollectionViewItem alloc] init],
        terrainItemView = [[TerrainItemView alloc] initWithFrame:CGRectMakeZero()];
    [terrainItemPrototype setView:terrainItemView];
    [_terrainView setItemPrototype:terrainItemPrototype];
    
    // Configure our ScrollView (ourself) to view the map
    [self setDocumentView:_terrainView];
    [self setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    [self setAutohidesScrollers:YES];
  }
  
  return self;
}

- (void)setMapModel:(MapModel)aMapModel
{
  // Calculate the width and height of this map in pixels based on the tile width and height
  var terrainViewBounds = CGRectMake(0,0,[aMapModel pixelWidth], [aMapModel pixelHeight]);
  [_terrainView setBounds:terrainViewBounds];
  
  [_terrainView setContent:[aMapModel terrainItemModels]];
}
