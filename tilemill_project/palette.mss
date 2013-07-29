/* ================================================================== */
/* FONTS
/* ================================================================== */

/* directory to load fonts from in addition to the system directories */
Map { font-directory: url(./fonts); }

/* set up font sets for various weights and styles */
@sans_lt:           "Open Sans Regular","DejaVu Sans Book","unifont Medium";
@sans_lt_italic:    "Open Sans Italic","DejaVu Sans Italic","unifont Medium";
@sans:              "Open Sans Semibold","DejaVu Sans Book","unifont Medium";
@sans_italic:       "Open Sans Semibold Italic","DejaVu Sans Italic","unifont Medium";
@sans_bold:         "Open Sans Bold","DejaVu Sans Bold","unifont Medium";
@sans_bold_italic:  "Open Sans Bold Italic","DejaVu Sans Bold Italic","unifont Medium";

/* Some fonts are larger or smaller than others. Use this variable to
   globally increase or decrease the font sizes. */
/* Note this is only implemented for certain things so far */
@text_adjust: 0;

/* ================================================================== */
/* COLORS
/* ================================================================== */

@water:             #D2EBFA;
@land:              rgb(255, 208, 70);
@road:              rgb(200, 7, 82);

@road_outline:      @land;


@motorway: 2; 
@mainroad: 1.7;
@minorroad: 1;

@motorway_outline: 8; 
@mainroad_outline: 7.5;
@minorroad_outline: 5;