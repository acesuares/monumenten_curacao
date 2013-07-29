# Roads

Overpass API
http://overpass-turbo.eu/

  <!--
  This is an example Overpass query.
  Try it out by pressing the Run button above!
  You can find more examples with the Load tool.
  -->
  <query type="way">
    <has-kv k="highway"/>
    <bbox-query {{bbox}}/><!--this is auto-completed with the
                     current map view coordinates.-->
  </query>
  <!-- added by auto repair -->
  <union>
    <item/>
    <recurse type="down"/>
  </union>
  <!-- end of auto repair -->
  <print/>
  
# Water

  <!--
  This is an example Overpass query.
  Try it out by pressing the Run button above!
  You can find more examples with the Load tool.
  -->
  <query type="way">
    <has-kv k="natural" v="water"/>
    <bbox-query {{bbox}}/><!--this is auto-completed with the
                     current map view coordinates.-->
  </query>
  <!-- added by auto repair -->
  <union>
    <item/>
    <recurse type="down"/>
  </union>
  <!-- end of auto repair -->
  <print/>
  
# Airport
  
  ( SELECT way, aeroway AS type
    FROM planet_osm_line
    WHERE aeroway IN ('apron', 'runway', 'taxiway')
  ) AS data