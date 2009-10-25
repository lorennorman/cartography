/*
 * AppController.j
 * temp
 *
 * Created by You on October 25, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "TerrainPaletteView.j"
/*@import "MapView.j"*/

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
  // Top-level window creation, full browser dimensions
  var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];
  // Extract the contentView of the top-level window
  var contentView = [theWindow contentView];
  // Set our background color
  [contentView setBackgroundColor:[CPColor grayColor]];
  // Make this window the front window
  [theWindow orderFront:self];
  
  // Convenience variable for creating children
  var viewFrame = [contentView frame];
  
  // Create a TerrainPaletteView positioned against the right border of the contentView
  var terrainPaletteView = [[TerrainPaletteView alloc]
                            initWithFrame:CGRectMake(
                                                      CGRectGetWidth(viewFrame) - [TerrainPaletteView width],
                                                      0,
                                                      [TerrainPaletteView width],
                                                      CGRectGetHeight(viewFrame)
                                                    )
                           ];
  // Allow it to resize vertically and stick to the right border
  [terrainPaletteView setAutoresizingMask: CPViewHeightSizable | CPViewMinXMargin];
  // Add it to the view
  [contentView addSubview:terrainPaletteView];
  
  // Create a MapView maximized in the remaining space against the left border
  
}

@end
