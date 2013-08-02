var map, 
  monumentsLayer, museumsLayer, routesLayer;
function initMap() {
	
	map = L.map('map').setView([12.109913, -68.937321], 15);
 	map.locate({setView: true, maxZoom: 21});
 
 var lineStyle = {
    color: "#CE2027",
    weight: 3,
    opacity: 0.90
  };

  var pointStyle = {
    radius: 5,
    //fillColor: "#ed7cff",
    //color: "#000000",
    weight: 1,
    opacity: 1,
    fillOpacity: 0.9
  };

  //TODO: set maximum map bounds
  L.tileLayer('http://a.tiles.mapbox.com/v3/acesuares.curacao-monuments-2/{z}/{x}/{y}.png', {
  //L.tileLayer('http://bertspaan.github.io/monumenten_curacao/tiles/{z}/{x}/{y}.png', {
    minZoom: 11,
    maxZoom: 19,
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
  }).addTo(map);      


  function onLocationFound(e) {
		var radius = e.accuracy / 2;
		L.marker(e.latlng).addTo(map)
			.bindPopup("You are within " + radius + " meters from this point").openPopup();
		L.circle(e.latlng, radius).addTo(map);
	}
  map.on('locationfound', onLocationFound);
        
  // More info about Leaflet marker clustering:
  //   https://github.com/Leaflet/Leaflet.markercluster
  monumentsLayer = L.markerClusterGroup({
    //disableClusteringAtZoom: 17
    showCoverageOnHover: false,
    spiderfyDistanceMultiplier: 1.2,
    maxClusterRadius: 10
  });

  function onEachFeature(feature, layer) {        
    layer.on('click', onFeatureClick);
  }
  
  museumsLayer = new L.geoJson(null, {
    style: lineStyle,
      onEachFeature: onEachFeature,
      pointToLayer: function (feature, latlng) {
        return L.circleMarker(latlng, pointStyle);
      }
  }).addTo(map);
  
  routesLayer = new L.geoJson(null, {
    style: lineStyle,
      onEachFeature: onEachFeature,
      pointToLayer: function (feature, latlng) {
        return L.circleMarker(latlng, pointStyle);
      }
  }).addTo(map);  
  
  //map.locate({setView: true, maxZoom: 16});
}

function addMapData(category, data){
  if (category === 'monuments') {
    
    var monumentIcon = L.icon({
      iconUrl: 'images/monument.png',
      iconSize:     [25, 30],
      iconAnchor:   [12, 15]
    });
    
    for (var i = 0; i < data.features.length; i++) {
      var feature = data.features[i];
      var latlng = new L.LatLng(feature.geometry.coordinates[1], feature.geometry.coordinates[0]);
      var marker = L.marker(latlng, {icon: monumentIcon, properties: feature.properties});

      marker.on('click', onFeatureClick);
  		monumentsLayer.addLayer(marker);
    }
  	map.addLayer(monumentsLayer);
    
  } else if (category === 'museums') {
    for (var i = 0; i < data.features.length; i++) { 
      var feature = data.features[i];
      museumsLayer.addData(feature);          
    }
  } else if (category === 'routes') {
    for (var i = 0; i < data.features.length; i++) { 
      var feature = data.features[i];
      routesLayer.addData(feature);          
    }
  }
	
}
