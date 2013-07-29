#curacao::line,
#water {
  
  line-color: darken(@land, 20%);
  line-width: 5;
  line-opacity: 1;
}


#curacao {
  polygon-fill: @land;
  //polygon-opacity: 0.2;
  //polygon-pattern-file: url("img/hexagon.png");
  
  //line-color: @land;
  //line-width: 1.8
}

/* ================================================================== */
/* WATER
/* ================================================================== */

Map { 
  background-color: @water; 
}

#water {
  polygon-fill: @water;
  //line-color: @land;
  //line-width: 1.8
}

