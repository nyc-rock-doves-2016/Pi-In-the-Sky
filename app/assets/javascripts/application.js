// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

    function getState(results){
      for (i = 0; i < results[0].address_components.length; i++){
        if(results[0].address_components[i].types[0].includes("administrative_area_level_1")){
          return results[0].address_components[i].short_name
        }
      }
    }

    function getCity(results){
      for (i = 0; i < results[0].address_components.length; i++){
        if(results[0].address_components[i].types[0].includes("locality")){
          return results[0].address_components[i].short_name
        }
      }
    }

 function initMap() {
        var mapDiv = document.getElementById('map');
        var map = new google.maps.Map(mapDiv, {
          center: {lat: 40.7118739, lng: -74.002533},
          zoom: 10
        });
        var geocoder  = new google.maps.Geocoder();             //

        google.maps.event.addListener(map, 'click', function(event) {
          //store LAT/LON upon click of google
          var lat = (event.latLng.lat())
          var lng = (event.latLng.lng())
          latlength = Math.floor(lat * 10000000) / 10000000
          lnglength = Math.floor(lng * 10000000) / 10000000

          $.get("https://api.breezometer.com/baqi/?lat="+latlength+"&lon="+lnglength+"&key=c0bfb33a27924f7e95a828abc931d5a0").then(function(response){
            // reverse geolocate address based on coordinates
            if(response.data_valid == true){

              $('#favorite').css("visibility", "visible")
               $('#output').css("visibility", "visible")

            } else {
              $('#favorite').css("visibility", "hidden")
              $('#output').css("visibility", "visible")
            }

            $('#errors').html("")

            var location  = {lat: latlength, lng: lnglength}

            // turn coordinates into an object
            geocoder.geocode({'latLng': location}, function (results, status) {
              if(status == google.maps.GeocoderStatus.OK && response.data_valid == true) {
                city = getCity(results);
                state = getState(results);
              }


            // display AQI data on page

            if(response.data_valid == true){

              document.getElementById("city").innerHTML = [city, state]

              document.getElementById("AQI").innerHTML = [response.breezometer_aqi];

              document.getElementById("AQIdesc").innerHTML = [response.breezometer_description];

              document.getElementById("pollutant").innerHTML = response.dominant_pollutant_description
               ;

              document.getElementById("output").innerHTML = response.dominant_pollutant_text["effects"]
               ;

            } else {
                document.getElementById("city").innerHTML = ""

              document.getElementById("AQI").innerHTML = "";

              document.getElementById("AQIdesc").innerHTML = "";

              document.getElementById("pollutant").innerHTML = ""
               ;
              document.getElementById("output").innerHTML =
              "Air quality cannot be read. You may be on the brink of death."

            }
            // POST response to server to create AQI object
            $.ajax({
                  url: '/global_data_objects',
                  dataType: 'json',
                  method: 'post',
                  data: {response:response, city:city, state:state, "authenticity_token": AUTH_TOKEN}
                })
              })
            });
        // closing geocoder here to retain access to 'city' variable
            })
          }

// })


