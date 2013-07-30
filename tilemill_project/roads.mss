/* ==================================================================
   ROADS
/* ================================================================== */

#roads[bridge='yes']::outline {
  line-width: 7;
  line-color: @land;
}

#roads {
  line-color: @road;
  line-width: 0;
  line-join: round;
  line-cap: round;
  
  [highway='trunk'],
  [highway='trunk_link'] {
    line-width: @motorway;
  }
  [highway='primary'],
  [highway='primary_link'] {
	line-width: @mainroad;
  }
  [highway='secondary'],
  [highway='secondary_link'] {
    line-width: @mainroad;
  }

  [highway='residential'],
  [highway='tertiary'],
  [highway='pedestrian'],
  [highway='footway'] {
    
    [zoom>11][zoom<=13] {
      line-color: lighten(@road, 10%);
	  line-width: @minorroad;
    }
    [zoom>13] {
	  line-width: @minorroad;
    }
  }
}
