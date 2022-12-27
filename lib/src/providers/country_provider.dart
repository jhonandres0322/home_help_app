import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryProvider{
  final _urlPaises = "https://restcountries.com/v2/all";
  final _urlCities = "https://countriesnow.space/api/v0.1/countries/cities";

  List countries = [];
  getCountries() async{
    final resp = await http.get(Uri.parse(_urlPaises));
    List<dynamic> result = json.decode(resp.body);
    result.forEach((country) { 
      print("country --> $country");
      final countryTemp = {};
      countryTemp["nameView"] = country["translations"]["es"];
      countryTemp["nameRequest"] = country["name"];
      countries.add(countryTemp);
    });
    print("countries --> $countries");
    
  }
  /*
  Future<dynamic> getCountriesAndCities()async{
    final resp = await http.get(
      Uri.parse(_url)
    );
    final result = json.decode(resp.body);
    print("provider result --> $result");
    return result;
  }
  */
}