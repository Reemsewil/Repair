//

// import 'package:geolocator/geolocator.dart';
// import 'package:prayer_tracking_app/core/constants/key_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LocationService {
//   static const String _latitudeKey = KeyManager.latitudeKey;
//   static const String _longitudeKey = KeyManager.longitudeKey;

//   static const double _defaultLatitude = 33.5138; //(Damascus)
//   static const double _defaultLongitude = 36.2765;

//   final SharedPreferences sharedPreferences;

//   LocationService({required this.sharedPreferences});

//   /// Initialize location once at app startup
//   Future<void> initializeLocation() async {
//     if (_hasSavedLocation()) return;

//     Position position = await _fetchLocation();
//     await _saveLocation(position.latitude, position.longitude);
//   }

//   /// Get the location & checking saved :
//   Future<Position> getCurrentLocation() async {
//     if (_hasSavedLocation()) {
//       return _getSavedPosition();
//     }
//     return await _fetchLocation();
//   }

//   ///
//   bool _hasSavedLocation() {
//     return sharedPreferences.containsKey(_latitudeKey) &&
//         sharedPreferences.containsKey(_longitudeKey);
//   }

//   Position _getSavedPosition() {
//     double latitude =
//         sharedPreferences.getDouble(_latitudeKey) ?? _defaultLatitude;
//     double longitude =
//         sharedPreferences.getDouble(_longitudeKey) ?? _defaultLongitude;

//     return Position(
//       latitude: latitude,
//       longitude: longitude,
//       timestamp: DateTime.now(),
//       accuracy: 10.0,
//       altitude: 0.0,
//       altitudeAccuracy: 10.0,
//       heading: 0.0,
//       headingAccuracy: 10.0,
//       speed: 0.0,
//       speedAccuracy: 10.0,
//       floor: null,
//       isMocked: false,
//     );
//   }

//   /// Fetch new location
//   Future<Position> _fetchLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     LocationPermission permission = await Geolocator.checkPermission();

//     if (!serviceEnabled ||
//         permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       return _getSavedPosition();
//     }

//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       return _getSavedPosition();
//     }

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.lowest,
//     );

//     await _saveLocation(position.latitude, position.longitude);
//     return position;
//   }

//   /// Save
//   Future<void> _saveLocation(double latitude, double longitude) async {
//     await sharedPreferences.setDouble(_latitudeKey, latitude);
//     await sharedPreferences.setDouble(_longitudeKey, longitude);
//   }
// }
