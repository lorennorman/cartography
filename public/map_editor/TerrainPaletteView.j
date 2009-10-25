@import <AppKit/CPView.j>

@implementation TerrainPaletteView : CPView
{
}

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
  }
  
  return self;
}

@end