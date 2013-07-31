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
  [highway='track'],
  [highway='footway'] {
    
    [zoom>11][zoom<=13] {
      line-color: lighten(@road, 12%);
	  line-width: @minorroad;
    }
    [zoom>13] {
      line-color: lighten(@road, 8%);
	  line-width: @minorroad;
    }
  }
}



/* ================================================================== */
/* Labels
/* ================================================================== */

#roads::labels[highway='trunk'][zoom>12],
#roads::labels[highway='primary'][zoom>12],
#roads::labels[highway='secondary'][zoom>13],
#roads::labels[highway='tertiary'][zoom>13] {
  text-name:'[name]';
  text-face-name:@sans;
  text-placement:line;
  text-fill:@road_text;
  text-halo-fill:@road_halo;
  text-halo-radius:1;
  text-min-distance:60;
  text-size:11;
}

#roads::labels[zoom>14] {
  [bridge='yes'],
  [highway='track'],
  [highway='footway'],
  [highway='pedestrian'],
  [highway='residential'] {
    text-name:'[name]';
    text-face-name:@sans;
    text-placement:line;
    text-size:9;
    text-fill:@road_text;
    text-halo-fill:@road_halo;
    text-halo-radius:1;
    text-min-distance:60;
    text-size:11;
  }
}
