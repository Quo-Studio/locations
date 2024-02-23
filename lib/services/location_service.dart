import 'package:location/api/location_api_client_impl.dart';
import 'package:location/models/location.dart';
import 'package:location/api/location_api_client.dart';

class LocationService {
  final LocationApiClient locationApiClient;

  LocationService() : locationApiClient = LocationApiClientImpl();

  Future<List<Location>> getLocations() async {
    List<Location> list = await locationApiClient.getLocations();
    return list;
  }

  Future<Location> getLocation(int id) {
    return locationApiClient.getLocation(id);
  }
}
