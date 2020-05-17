import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Map extends StatefulWidget {
  Map({Key key, this.latitude, this.longitude}) : super(key: key);
  final double latitude;
  final double longitude;
  //pass in list of found breweries, seperate user loc and brewery locations
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  //Icons.local_drink
  //pin drops for each local brewery
  //on pin click, bottom dialog with information
  //loop throuhg list of found locations, markerlayeroptions for each one
  @override
  Widget build(BuildContext context) {
  return new FlutterMap(
    options: new MapOptions(
      center: new LatLng(widget.latitude,widget.longitude),
      zoom: 13.0,
    ),
    layers: [
      new TileLayerOptions(
        urlTemplate: "https://api.mapbox.com/styles/v1/dzjon/ckaa4wm6a1upl1jmo52gbp5ym/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZHpqb24iLCJhIjoiY2thYTN3NzN5MGpmcTJ5bjVyNHhyY3hleSJ9.d5-h3wE7qfhgNGoQL0PTJg",
        additionalOptions: {
          'accessToken': DotEnv().env['MAPBOX_ACCESS_TOKEN'],
          'id': 'mapbox.mapbox-streets-v8',
        },
      ),
      new MarkerLayerOptions(
        markers: [
          new Marker(
            width: 80.0,
            height: 80.0,
            point: new LatLng(widget.latitude, widget.longitude),
            builder: (ctx) =>
            new Container(
              child: new Icon(
                Icons.person_pin,
                color: Colors.pink,
                size: 80,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
}
