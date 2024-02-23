import 'package:location/models/location.dart';
import 'package:location/models/locations_data.dart';
import 'package:location/api/location_api_client.dart';

class LocationApiData implements LocationApiClient {
  @override
  Future<List<Location>> getLocations() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => LocationsData.buildList(),
    );
  }

  @override
  Future<Location> getLocation(int id) {
    Location location =
        LocationsData.buildList().where((element) => element.id == id).first;

    return Future.delayed(const Duration(seconds: 1), () => location);
  }
}
