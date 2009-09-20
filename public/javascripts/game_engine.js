$(function() {
  game_div = $('#game_container');
  // Read level data
  var LEVEL_DATA = 
  [ 
    [1,2,3,2,3,2,1],
    [2,3,3,4,2,1,1],
    [1,2,1,1,2,3,3],
    [3,3,2,2,1,1,2]
  ];
  // Create level object (implies dom)
  var this_level = Level(LEVEL_DATA);
  // Read unit data
  // Add units to level object (and dom)
});

// What types of terrain are available and what are their attributes?
TERRAIN_TYPES = 
{
  1: "FF0000",
  2: "00FF00",
  3: "0000FF",
  4: "FFFF00"
};

// Level has all the tiles
var Level = function(level_data)
{
  $.each(level_data, function(y) {
    $.each(this, function(x) {
      game_div.append(Tile({x:x,y:y,type:TERRAIN_TYPES[this]}));
    });
  });
};

// A tile is a single gameplay square
var Tile = function(options)
{
  // creates dom elements, gives them an appearance, puts them in certain places (BAD DESIGN!)
  return $('<div class="tile" style="left:'+options['x']*50+'px;top:'+options['y']*50+'px;background-color:'+options['type']+'">&nbsp;</div>')
};