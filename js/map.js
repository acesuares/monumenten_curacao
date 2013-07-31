var map;
function initMap(){
	
	map = L.map('map').setView([12.136613, -68.937321], 13);

  L.tileLayer('http://bertspaan.github.io/monumenten_curacao/tiles/{z}/{x}/{y}.png', {
    minZoom: 11,
    maxZoom: 16,
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
  }).addTo(map);      

  $.getJSON('https://rawgithub.com/bertspaan/monumenten_curacao/master/monuments.json', function(data) {
    L.geoJson(data).addTo(map);
  });

  function onLocationFound(e) {
		var radius = e.accuracy / 2;
		L.marker(e.latlng).addTo(map)
			.bindPopup("You are within " + radius + " meters from this point").openPopup();
		L.circle(e.latlng, radius).addTo(map);
	}
  
	map.on('locationfound', onLocationFound);
	map.locate({setView: true, maxZoom: 16});
	
}