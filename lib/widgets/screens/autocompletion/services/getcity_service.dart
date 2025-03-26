import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:hously_flutter/widgets/screens/autocompletion/models/city_model.dart';

class CityService {
  // Function to get cities from JSON
  Future<List<City>> getCities() async {
    // Load the JSON file from assets
    final jsonString =
        await rootBundle.loadString('assets/countries.json');

    // Decode the JSON data
    Map<String, dynamic> jsonData = json.decode(jsonString);

    // Access the cities list from the parsed JSON
    List<dynamic> jsonList = jsonData['cities'];

    // Convert JSON list to City objects
    return jsonList.map((json) => City.fromJson(json)).toList();
  }

  // Function to convert cities back to JSON
  String citiesToJson(List<City> cities) {
    return json.encode({
      'cities': cities.map((city) => city.toJson()).toList(),
    });
  }
}
