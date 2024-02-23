import 'dart:convert';

import 'package:location/api/location_api_client.dart';
import 'package:location/models/location.dart';
import 'package:http/http.dart' as http;

class LocationApiClientImpl implements LocationApiClient {
  static Future<List<Location>> fetchLocations() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2/api/locations/locations.json'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as List;
      return parsed.map((location) => Location.fromJson(location)).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  @override
  Future<Location> getLocation(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Location>> getLocations() {
    return fetchLocations();
  }
}
