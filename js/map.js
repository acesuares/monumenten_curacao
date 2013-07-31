var map;
function initMap(data){
	
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
  
  function onFeatureClick(e) {
    console.log("test");

  }

  function onEachFeature(feature, layer) {        
    layer.on('click', onFeatureClick);
  }
  
  // https://github.com/Leaflet/Leaflet.markercluster
  var markers = L.markerClusterGroup({
    //disableClusteringAtZoom: 17
    showCoverageOnHover: false
  });
  
  for (var i = 0; i < data.features.length; i++) {
    var feature = data.features[i];
    var latlng = new L.LatLng(feature.geometry.coordinates[1], feature.geometry.coordinates[0]);
		var marker = L.marker(latlng, feature.properties);
		//marker.bindPopup(title);
		markers.addLayer(marker);
  }
	map.addLayer(markers);

	//map.locate({setView: true, maxZoom: 16});
	
}