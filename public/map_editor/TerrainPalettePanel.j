@import <AppKit/CPPanel.j>
@import "TerrainBrushView.j"

@implementation TerrainPalettePanel : CPPanel
{
  CPCollectionView _terrainTypesView;
}

// The width of the palette is always the same (is this right? if so is this the right way to do this?)
+ (int)width
{
  return 200;
}

- (id)init
{
  self = [super initWithContentRect:CGRectMake(50.0, 50.0, 300.0, 400.0)
                styleMask: CPHUDBackgroundWindowMask | CPResizableWindowMask];
  
  if (self)
  {
    [self setTitle:"Terrain Picker"]; 
    [self setFloatingPanel:YES]; 
    //[self setBackgroundColor:[CPColor blackColor]];
    
    var contentView = [self contentView],
        bounds = [contentView bounds];
    
    // Initialize the CollectionView and its layout
    _terrainTypesView = [[CPCollectionView alloc] initWithFrame:bounds];
    [_terrainTypesView setAutoresizingMask:CPViewWidthSizable];
    [_terrainTypesView setMinItemSize:CGSizeMake(100, 120)];
    [_terrainTypesView setMaxItemSize:CGSizeMake(100, 120)];
    
    // Set up the CollectionView to use TerrainBrushViews as children
    var itemPrototype = [[CPCollectionViewItem alloc] init],
        terrainBrushView = [[TerrainBrushView alloc] initWithFrame:CGRectMakeZero()];
    [itemPrototype setView:terrainBrushView];
    [_terrainTypesView setItemPrototype:itemPrototype];
    
    // Create a ScrollView to embed our CollectionView in for vertical scrolling
    var scrollView = [[CPScrollView alloc] initWithFrame:bounds];
    
    [scrollView setDocumentView:_terrainTypesView];
    [scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    [scrollView setAutohidesScrollers:YES];
    //[[scrollView contentView] setBackgroundColor:[CPColor whiteColor]];
    
    [contentView addSubview:scrollView];
    
    // Ask the server for the actual TerrainTypes
    [self requestTerrainTypes];
  }
  
  return self;
}

-(void)requestTerrainTypes
{
  // Set up our request to the terrain_types index action
  var request = [CPURLRequest requestWithURL:'/terrain_types.json'];
  
  // Fire off the request! This object will handle the response.
  [CPURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(CPURLConnection)aConnection didReceiveData:(CPString)data
{
  // Parse the response JSON into a data object
  var terrainBrushData = CPJSObjectCreateWithJSON(data);
  
  // Seed the CollectionView with the data object
  [_terrainTypesView setContent:terrainBrushData];
}

- (void)connection:(CPURLConnection)aConnection didFailWithError:(CPError)anError
{
  alert("Error!");
  alert(anError);
}

@end











