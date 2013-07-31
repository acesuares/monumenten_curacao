var map, monuments;
function initMap() {
	
	map = L.map('map').setView([12.109913, -68.937321], 15);

  //TODO: set maximum map bounds
  L.tileLayer('http://bertspaan.github.io/monumenten_curacao/tiles/{z}/{x}/{y}.png', {
    minZoom: 11,
    maxZoom: 17,
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
  }).addTo(map);      

  function onLocationFound(e) {
		var radius = e.accuracy / 2;
		L.marker(e.latlng).addTo(map)
			.bindPopup("You are within " + radius + " meters from this point").openPopup();
		L.circle(e.latlng, radius).addTo(map);
	}
  map.on('locationfound', onLocationFound);
        
  // https://github.com/Leaflet/Leaflet.markercluster
  monuments = L.markerClusterGroup({
    //disableClusteringAtZoom: 17
    showCoverageOnHover: false
  });
  
  //map.locate({setView: true, maxZoom: 16});
}

function addMapData(category, data){

  if (category === 'monuments') {
    
    for (var i = 0; i < data.features.length; i++) {
      var feature = data.features[i];
      var latlng = new L.LatLng(feature.geometry.coordinates[1], feature.geometry.coordinates[0]);
      var marker = L.marker(latlng, feature.properties);
    
      marker.on('click', onFeatureClick);
  		monuments.addLayer(marker);
    }
  	map.addLayer(monuments);
    
  } else if (category === 'museums') {



  }

	
}