@import <AppKit/CPView.j>
@import "TerrainBrushView.j"

@implementation TerrainPaletteView : CPView
{
  CPCollectionView _terrainTypesView;
}

// The width of the palette is always the same (is this right? if so is this the right way to do this?)
+ (int)width
{
  return 200;
}

- (id)initWithFrame:(CGRect)aFrame
{
  self = [super initWithFrame:CGRectMake(CGRectGetMinX(aFrame),
                                         CGRectGetMinY(aFrame), 
                                         [TerrainPaletteView width],
                                         CGRectGetHeight(aFrame))];
  
  if (self)
  {
    [self setBackgroundColor:[CPColor blackColor]];
    
    var bounds = [self bounds];
    
    // Initialize the CollectionView and its layout
    _terrainTypesView = [[CPCollectionView alloc] initWithFrame:bounds];
    [_terrainTypesView setAutoresizingMask:CPViewHeightSizable];
    [_terrainTypesView setMinItemSize:CGSizeMake(200, 100)];
    [_terrainTypesView setMaxItemSize:CGSizeMake(200, 100)];
    
    // Set up the CollectionView to use TerrainBrushViews as children
    var itemPrototype = [[CPCollectionViewItem alloc] init],
        terrainBrushView = [[TerrainBrushView alloc] initWithFrame:CGRectMakeZero()];
    [itemPrototype setView:terrainBrushView];
    [_terrainTypesView setItemPrototype:itemPrototype];
    
    // Create a ScrollView to embed our CollectionView in for vertical scrolling
    var scrollView = [[CPScrollView alloc] initWithFrame:bounds];
    
    [scrollView setDocumentView:_terrainTypesView];
    [scrollView setAutoresizingMask:CPViewHeightSizable];
    [scrollView setAutohidesScrollers:YES];
    //[[scrollView contentView] setBackgroundColor:[CPColor whiteColor]];
    
    [self addSubview:scrollView];
    
    // Now create some data to populate the TerrainBrushViews
    var terrainBrushData = [
                             'forest',
                             'mountain',
                             'ocean',
                             'grassland',
                             'desert',
                             'road',
                             'plains'
                           ];
    
    [_terrainTypesView setContent:terrainBrushData];
  }
  
  return self;
}

@end











