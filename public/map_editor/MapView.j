@import <AppKit/CPView.j>
@import "MapModel.j"
@import "TerrainItemView.j"

TILE_WIDTH = 100;
TILE_HEIGHT = 80;

@implementation MapView : CPView
{
}

- (id)init
{
  self = [super initWithFrame:CGRectMakeZero()];
  
  if (self)
  {
    [self setBackgroundColor:[CPColor blackColor]];
    [self setAutoresizingMask:nil];
    
  }
  
  return self;
}

- (void)setMapModel:(MapModel)aMapModel
{
  // Calculate the width and height of this map in pixels based on the tile width and height
  var terrainViewBounds = CGSizeMake(0,0,[aMapModel width]*TILE_WIDTH, [aMapModel height]*TILE_HEIGHT);
  [self setFrame:CGRectMake(0, 0,
                             [aMapModel width]*TILE_WIDTH + TILE_WIDTH*1.5,
                             [aMapModel height]*TILE_HEIGHT + TILE_HEIGHT)];
  
  // Variables for iteration over the rows
  var terrainItemPrototype = [[CPCollectionViewItem alloc] init];
  var terrainItemView = [[TerrainItemView alloc] initWithFrame:CGRectMakeZero()];
  [terrainItemPrototype setView:terrainItemView];
  var terrainItemRows = [aMapModel terrainItemRows];
  
  // For each row of Cells
  for(var rowNumber=0; rowNumber < terrainItemRows.length; rowNumber++)
  {
    // Padding from the outside
    var padding = TILE_WIDTH/2;
    // Every other row is offset by half a tile
    var pixelsFromLeft = padding + ((rowNumber % 2 != 0) ? TILE_WIDTH/2 : 0);
    // Each row must move further down the layout
    var pixelsFromTop = padding + TILE_HEIGHT * rowNumber;
    var rowCollectionView = [[CPCollectionView alloc] initWithFrame:CGRectMake(pixelsFromLeft,
                                                                               pixelsFromTop,
                                                                               [aMapModel width] * TILE_WIDTH,
                                                                               TILE_HEIGHT)];
    // Tile sizing and spacing
    [rowCollectionView setVerticalMargin:0];
    [rowCollectionView setMinItemSize:CGSizeMake(TILE_WIDTH, TILE_HEIGHT)];
    [rowCollectionView setMaxItemSize:CGSizeMake(TILE_WIDTH, TILE_HEIGHT)];
    
    // Make sure the CollectionView lays out only one row (not a grid)
    [rowCollectionView setMaxNumberOfColumns:[aMapModel width]];
    [rowCollectionView setMaxNumberOfRows:1];
    
    // Set up the CollectionView to use TerrainItemViews as children
    [rowCollectionView setItemPrototype:terrainItemPrototype];
    
    [rowCollectionView setContent:terrainItemRows[rowNumber]];
    
    // Add this row to the screen
    [self addSubview:rowCollectionView];
  }
}
