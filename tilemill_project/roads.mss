/* ==================================================================
   ROADS
/* ================================================================== */

#roads::outline,
#bridge::outline ,
 {
  line-color: @road_outline;
  line-width: 0;
  line-join: round;
  line-cap: round;
  [highway='trunk'] {
    line-width: @motorway_outline;
  }
  [highway='primary'] {
    line-width: @mainroad_outline;
  }/*
  [zoom>14][stylegroup='minorroad'] {
    line-width: @minorroad_outline;
  }*/
}

#roads,
#bridge {
  line-color: @road;
  line-width: 0;
  line-join: round;
  line-cap: round;
  [highway='trunk'] {
    line-width: @motorway;
  }
  [highway='primary'] {
    line-width: @mainroad;
  }/*
  [zoom>14][stylegroup='minorroad'] {
    line-width: @minorroad;
  }*/
}


#aeroway::outline {
  line-color: @road_outline;
  line-width: @motorway_outline;
}

#aeroway {
  line-color: @road;
  line-width: @motorway;
}
