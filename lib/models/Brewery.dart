import 'dart:convert';
// import 'package:beer/services/http_service.dart';
import 'package:http/http.dart' as http;

class Brewery {
  final int id;
  final String name;
  final String breweryType;
  final String city;
  final String state;
  final String street;
  final String postalCode;
  final String country;
  final String latitude;
  final String longitude;
  final String phone;
  final String websiteUrl;

  Brewery(
    this.id,
    this.name,
    this.breweryType,
    this.city,
    this.state,
    this.street,
    this.postalCode,
    this.country,
    this.latitude,
    this.longitude,
    this.phone,
    this.websiteUrl,
  );
  @override
  toString() => 'Brewery: $name';
  
  factory Brewery.fromJson(Map<String, dynamic> json) {
    return new Brewery(
      json['id'],
      json['name'],
      json['brewery_type'],
      json['city'],
      json['state'],
      json['street'],
      json['postal_code'],
      json['country'],
      json['latitude'],
      json['longitude'],
      json['phone'],
      json['website_url'],
    );
  }
  //going to need a class/interface for abbv state strings (SC = south carolina etc.)
  static Future<List<Brewery>> get(String city, String state) async {
    if(state == 'SC') {
      state = 'south_carolina';
    }
    var url =
        'https://api.openbrewerydb.org/breweries?by_city=$city&by_state=$state';
    var response = await http.get(url);
   // var response = await fetchLocalBreweries(city,state);
    final responseJson = json.decode(response.body);
    final items =
        (responseJson as List).map((i) => new Brewery.fromJson(i)).toList();
    return items;
  }
}
