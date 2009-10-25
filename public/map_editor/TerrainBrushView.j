@import <AppKit/CPView.j>

@implementation TerrainBrushView : CPView
{
  CPTextField _labelView;
}

- (void)setRepresentedObject:(id)anObject
{
  // Initialize our subviews if needed
  if(!_labelView)
  {
    var frame = CGRectInset([self bounds], 20.0, 20.0);
    
    _labelView = [[CPTextField alloc] initWithFrame:frame];
    [_labelView setEditable:NO];
    [_labelView setTextColor:[CPColor whiteColor]];
    [_labelView setBackgroundColor:[CPColor grayColor]];
    
    [self addSubview:_labelView];
  }
  
  // Do the actual update (anObject is just a CPString for now)
  [_labelView setStringValue:anObject];
  [_labelView sizeToFit];
}

- (void)setSelected:(BOOL)isSelected 
{ 
  [self setBackgroundColor:isSelected ? [CPColor grayColor] : nil]; 
} 

@end 