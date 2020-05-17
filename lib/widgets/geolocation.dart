import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:beer/widgets/map.dart';
import 'package:loading/loading.dart';
import 'package:http/http.dart' as http;
import 'package:beer/interfaces/Brewery.dart';

class Geolocation extends StatefulWidget {
  Geolocation({Key key}) : super(key: key);
  @override
  GeolocationState createState() => GeolocationState();
}

class GeolocationState extends State<Geolocation> {
  Geolocator geolocator = new Geolocator();
  //for map widget
  Position currentLatitudeLongitude;
  var breweriesNearUser;
  //for get breweries
  String currentAddress;
  String currentCity;
  String currentState;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  dispose() {
    super.dispose();
    geolocator = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breweries Near Me'),
        elevation: 5,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: currentLatitudeLongitude != null
                ? Map(
                    latitude: currentLatitudeLongitude.latitude,
                    longitude: currentLatitudeLongitude.longitude)
                : Loading(
                    color: Colors.pink,
                    size: 100,
                  ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            alignment: Alignment.bottomCenter,
            child: ButtonTheme(
              minWidth: 200,
              child: RaisedButton(
                child: Text('Refresh'),
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0)),
                onPressed: () => {
                  _getCurrentPosition(),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getCurrentPosition() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      setState(() {
        currentLatitudeLongitude = position;
      });
      await _getAddressFromLatLng();
      await _getLocalBreweries(currentCity, currentState);
    }).catchError((e) {
      print(e);
    });
  }

  // openbrewerydb
  _getLocalBreweries(String city, String state) async {
    breweriesNearUser = await Brewery.get(city, state);
    // try {
    //   var response = await http.get('https://api.openbrewerydb.org/breweries?by_city=san_diego');
    //   breweriesNearUser = response.body;
    //   print(breweriesNearUser);
    // } catch(error) {
    //   //snackbar/alert
    //   print(error);
    // }
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentLatitudeLongitude.latitude,
          currentLatitudeLongitude.longitude);

      Placemark place = p[0];
      setState(() {
        currentCity = place.locality;
        currentState = place.administrativeArea;
      });
    } catch (e) {
      print(e);
    }
  }
}
