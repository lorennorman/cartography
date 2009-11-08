@import <AppKit/CPPanel.j>
@import "TerrainBrushView.j"

@implementation TerrainPalettePanel : CPPanel
{
  CPCollectionView _terrainTypesView;
  CPButton _refreshButton;
  CPTextField _filterTextField;
}

// The width of the palette is always the same (is this right? if so is this the right way to do this?)
+ (int)width
{
  return 200;
}

- (id)init
{
  self = [super initWithContentRect:CGRectMake(800.0, 50.0, 300.0, 400.0)
                styleMask: CPHUDBackgroundWindowMask | CPResizableWindowMask];
  
  if (self)
  {
    [self setTitle:"Terrain Picker"]; 
    [self setFloatingPanel:YES]; 
    
    var contentView = [self contentView],
        bounds = [contentView bounds];
    
    // Create the Refresh button
    _refreshButton = [CPButton buttonWithTitle:"Refresh"];
    
    // Position the Refresh button right-aligned
    var rbOrigin = CPMakePoint(bounds.size.width - [_refreshButton bounds].size.width - 10, 10);
    [_refreshButton setFrameOrigin:rbOrigin];
    [_refreshButton setAutoresizingMask:CPViewMinXMargin]
    
    // Set the Refresh button's action to call the server-update function
    [_refreshButton setTarget:self];
    [_refreshButton setAction:@selector(requestTerrainTypes:)]; 
    
    // Add the Refresh button
    [contentView addSubview:_refreshButton];
    
    // Create the Filter field
    _filterTextField = [CPTextField textFieldWithStringValue:"" 
                                    placeholder:"Search Filter" 
                                    width:bounds.size.width - [_refreshButton bounds].size.width - 20];
    
    // Position the Filter field full width from left bound to Refresh button
    [_filterTextField setFrameOrigin:CPMakePoint(10, 8)];
    [_filterTextField setAutoresizingMask:CPViewWidthSizable];
    // Add the Filter field
    [contentView addSubview:_filterTextField];
    
    // Initialize the CollectionView and its layout
    _terrainTypesView = [[CPCollectionView alloc] initWithFrame:CGRectInset(bounds, 10, 0)];
    [_terrainTypesView setAutoresizingMask:CPViewWidthSizable];
    [_terrainTypesView setMinItemSize:CGSizeMake(100, 120)];
    [_terrainTypesView setMaxItemSize:CGSizeMake(100, 120)];
    
    // Set up the CollectionView to use TerrainBrushViews as children
    var itemPrototype = [[CPCollectionViewItem alloc] init],
        terrainBrushView = [[TerrainBrushView alloc] initWithFrame:CGRectMakeZero()];
    [itemPrototype setView:terrainBrushView];
    [_terrainTypesView setItemPrototype:itemPrototype];
    
    // Create a ScrollView to embed our CollectionView in for vertical scrolling
    var paletteBounds = CGRectInset(bounds, 0, 20);
    paletteBounds.origin.y += 30;
    paletteBounds.size.height -= 30;
    var scrollView = [[CPScrollView alloc] initWithFrame:paletteBounds];
    
    [scrollView setDocumentView:_terrainTypesView];
    [scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    [scrollView setAutohidesScrollers:YES];
    //[[scrollView contentView] setBackgroundColor:[CPColor whiteColor]];
    
    [contentView addSubview:scrollView];
    
    // Ask the server for the actual TerrainTypes
    [self requestTerrainTypes:nil];
  }
  
  return self;
}

-(void)requestTerrainTypes:(id)aSender
{
  // Clear the terrain palette so we know something is happening
  [_terrainTypesView setContent:[]];
  
  // Build our request URL with the appropriate parameters
  var params = "?";
  var paramsObject = {
    "name_filter":[_filterTextField objectValue]
  };
  for (param in paramsObject) {
    params += param + "=" + paramsObject[param] + "&";
  }
  
  var requestURL = '/terrain_types.json' + params;
  
  // Set up our request to the terrain_types index action
  var request = [CPURLRequest requestWithURL:requestURL];
  
  // Fire off the request! This object will handle the response.
  [CPURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(CPURLConnection)aConnection didReceiveData:(CPString)data
{
  // Parse the response JSON into a data object
  var terrainBrushData = JSON.parse(data);
  
  // Add these terrain models to the cache
  [TerrainItemModel setAvailableTerrainModels:terrainBrushData];
  
  var terrainItemModelArray = [];
  
  for(var index=0;index < terrainBrushData.length; index++)
  {
    terrainItemModelArray.push([TerrainItemModel findById:terrainBrushData[index].id]);
  }
  
  // Seed the CollectionView with the data object
  [_terrainTypesView setContent:terrainItemModelArray];
}

- (void)connection:(CPURLConnection)aConnection didFailWithError:(CPError)anError
{
  alert("Error!");
  alert(anError);
}

@end