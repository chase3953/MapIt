<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MapItChase.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Geocoding Service</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        #map {
            height: 100%;
        }

        #floating-panel {
            position: absolute;
            top: 10px;
            left: 25%;
            z-index: 5;
            background-color: #fff;
            padding: 5px;
            border: 1px solid #999;
            text-align: center;
            font-family: Roboto, sans-serif;
            line-height: 30px;
            padding-left: 10px;
        }
    </style>
</head>
<body>
    <div id="floating-panel">
        <input id="address" type="text" value="" />
        <input id="submit" type="button" value="GeoCode" />
    </div>
    <div id="map">
    </div>
    <script>
        function initMap() {

            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 8,
                center: { lat: -34.397, lng: 150.644 }
            });

            var geocoder = new google.maps.Geocoder();
            var infoWindow = new google.maps.InfoWindow({ map: map });

            document.getElementById('address').addEventListener('keydown', function (OBJECT) {
                if (OBJECT.keyCode == 13) {
                    geocodeAddress(geocoder, map);
                }
            });

            

            // Subscribe to the mouse click event
            document.getElementById('submit').addEventListener('click', function (OBJECT) {
                geocodeAddress(geocoder, map)
            });
            //See if the browser has html5 geolocation
            if (navigator.geolocation != null) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    var pos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };
                    infoWindow.setPosition(pos);
                    infoWindow.setContent('Location found.');
                    map.setCenter(pos)
                }, function () {
                    handleLocationError(true, infoWindow, map.getCenter());
                });
            } else {
                handleLocationError(false, infoWindow, map.getCenter())
            }

            function handleLocationError(browserHasGeoLocation, infoWindow, pos) {
                infoWindow.setPosition(pos);
                infoWindow.setContent(
                    browserHasGeoLocation ?
                    'Error: The Geoloacation service failed'
                    :
                    'Error: Your browser doesn\'t support geolocation.'
                    );
            }

        }// end of initMap

            function geocodeAddress(geocoderChase, resultMap) {
                var address = document.getElementById('address').value;
                geocoderChase.geocode({ 'address': address }, function (results, status) {
                    if (status === 'OK') {
                        resultMap.setCenter(results[0].geometry.location)
                        var marker = new google.maps.Marker({
                            map: resultMap,
                            position: results[0].geometry.location
                        });
                    } else {
                        alert('Geocode was not successful for the following reason: ' + status)
                    }
                });
            }
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA3dYMc1hlO31Fs10wvLLiwnhiqQ2JfCSM&callback=initMap">
     
    </script>
</body>
</html>
