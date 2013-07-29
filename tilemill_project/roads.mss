/* ==================================================================
   ROADS
/* ================================================================== */

#roads::outline,
#bridge::outline ,
 {
  line-color: @road_outline;
  line-width: 1;
  /*[stylegroup='motorway'] {
    line-width: @motorway_outline;
  }
  [stylegroup='mainroad'] {
    line-width: @mainroad_outline;
  }
  [zoom>14][stylegroup='minorroad'] {
    line-width: @minorroad_outline;
  }*/
}

#roads,
#bridge {
  line-color: @road;
  line-width: 0;
  /*[stylegroup='motorway'] {
    line-width: @motorway;
  }
  [stylegroup='mainroad'] {
    line-width: @mainroad;
  }
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
