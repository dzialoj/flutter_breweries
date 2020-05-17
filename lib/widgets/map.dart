import 'package:beer/interfaces/Brewery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Map extends StatefulWidget {
  Map(
      {Key key,
      this.latitude,
      this.longitude,
      this.city,
      this.state,
      this.breweries})
      : super(key: key);
  final double latitude;
  final double longitude;
  final String city;
  final String state;
  final List<Brewery> breweries;
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  //Icons.local_drink
  //pin drops for each local brewery
  //on pin click, bottom dialog with information
  //loop throuhg list of found locations, markerlayeroptions for each one
  @override
  void initState() {
    super.initState();
  }

  _generateMapMarkers() {
    List<Marker> markers = [];
    
    var userMarker = new Marker(
        point: new LatLng(widget.latitude, widget.longitude),
        builder: (ctx) => new Container(
                child: new Icon(
              Icons.person_pin,
              color: Colors.pink,
              size: 80,
            )));
    markers.add(userMarker);

    for (var brewery in widget.breweries) {
      var newMarker = new Marker(
        point: new LatLng(
          double.parse(brewery.latitude),
          double.parse(brewery.longitude),
        ),
        builder: (ctx) => new Container(
          child: new Icon(
            Icons.local_drink,
            color: Colors.pink,
            size: 80,
          ),
        ),
      );
      markers.add(newMarker);
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(widget.latitude, widget.longitude),
        zoom: 12.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/dzjon/ckaa4wm6a1upl1jmo52gbp5ym/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZHpqb24iLCJhIjoiY2thYTN3NzN5MGpmcTJ5bjVyNHhyY3hleSJ9.d5-h3wE7qfhgNGoQL0PTJg",
          additionalOptions: {
            'accessToken': DotEnv().env['MAPBOX_ACCESS_TOKEN'],
            'id': 'mapbox.mapbox-streets-v8',
          },
        ),
        new MarkerLayerOptions(
          markers: _generateMapMarkers(),
        ),
      ],
    );
  }
}
