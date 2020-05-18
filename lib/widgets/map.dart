import 'package:beer/interfaces/Brewery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

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

  //distance from you | business hours
  _launchUrl(url) async {
    try{
      if(await canLaunch(url)) {
        await(launch(url, forceWebView: true));
      } else {
        throw 'Could not launch url.';
      }
    } catch(error) {
      print(error);
    }
  }

  _launchPhoneCall(tel) async {
    try {
      if(await canLaunch(tel) && tel != "tel:") {
        await(launch(tel));
      } else {
        showDialog(
          context: context,
          child: AlertDialog(
            backgroundColor: Colors.pink,
            content: Text(
              'No number available.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )
              ),
          )
        );
        throw 'Could not call number.';
      }
    } catch(error) {
      print(error);
    }
  }

  _generateMapMarkers() {
    List<Marker> markers = List<Marker>();

    var userMarker = new Marker(
        point: new LatLng(widget.latitude, widget.longitude),
        builder: (ctx) => new Container(
                child: new Icon(
              Icons.person_pin,
              color: Colors.pink,
              size: 50,
            )));
    markers.add(userMarker);

    for (var brewery in widget.breweries) {
      if (brewery.latitude != null || brewery.longitude != null) {
        String address = "${brewery.street}\n\n"
            "${brewery.city}, ${brewery.state} ${brewery.postalCode}";

        var newMarker = new Marker(
          point: new LatLng(
            double.parse(brewery.latitude),
            double.parse(brewery.longitude),
          ),
          builder: (ctx) => new Container(
            width: 50,
            height: 50,
            child: new IconButton(
              icon: Icon(Icons.local_drink),
              iconSize: 30.0,
              color: Colors.pink,
              focusColor: Colors.pinkAccent,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              AppBar(title: Text(brewery.name)),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Icon(
                                        Icons.directions,
                                        color: Colors.pink,
                                        size: 50,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        address,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: IconButton(
                                        icon: Icon(Icons.phone),
                                        color: Colors.pink,
                                        iconSize: 50,
                                        onPressed: () => {
                                          _launchPhoneCall('tel:${brewery.phone}')
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        brewery.phone != ""
                                            ? brewery.phone
                                            : 'None',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: IconButton(
                                        icon: Icon(Icons.link),
                                        color: Colors.pink,
                                        iconSize: 50,
                                        onPressed: () => {
                                          _launchUrl(brewery.websiteUrl)
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        brewery.websiteUrl != ""
                                            ? brewery.websiteUrl
                                            : 'None',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Icon(
                                        Icons.local_drink,
                                        color: Colors.pink,
                                        size: 50,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        brewery.breweryType != ""
                                            ? '${brewery.breweryType[0].toUpperCase()}${brewery.breweryType.substring(1, brewery.breweryType.length)}'
                                            : 'None',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: ButtonTheme(
                                    minWidth: 200,
                                    child: RaisedButton(
                                      child: Text('Browse Beer'),
                                      color: Colors.pink,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(25.0)),
                                      onPressed: () => {print('beer view')},
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    });
              },
            ),
          ),
        );
        markers.add(newMarker);
      }
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
