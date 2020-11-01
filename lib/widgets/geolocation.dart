import 'package:beer/widgets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:beer/widgets/map.dart';
import 'package:loading/loading.dart';
import 'package:beer/models/Brewery.dart';

class Geolocation extends StatefulWidget {
  Geolocation({Key key}) : super(key: key);
  @override
  GeolocationState createState() => GeolocationState();
}

class GeolocationState extends State<Geolocation> {
  Geolocator geolocator = new Geolocator();
  //for map widget
  Position currentLatitudeLongitude;
  List<Brewery> breweries;
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
            child: currentLatitudeLongitude != null &&
                    currentCity != null &&
                    currentState != null &&
                    breweries != null
                ? Map(
                    latitude: currentLatitudeLongitude.latitude,
                    longitude: currentLatitudeLongitude.longitude,
                    city: currentCity,
                    state: currentState,
                    breweries: breweries,
                  )
                : Loading(
                    size: 100,
                    color: appColor,
                  ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            alignment: Alignment.bottomCenter,
            child: ButtonTheme(
              minWidth: 200,
              child: RaisedButton(
                child: Text('Refresh'),
                textColor: Colors.white,
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
        .then((Position position) {
      setState(() {
        currentLatitudeLongitude = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getLocalBreweries(String city, String state) async {
    await Brewery.get(city, state).then((res) {
      setState(() {
        breweries = res;
      });
    });
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
      await _getLocalBreweries(currentCity, currentState);
    } catch (e) {
      print(e);
    }
  }
}
