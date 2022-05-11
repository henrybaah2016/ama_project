import 'dart:convert';
import 'dart:io';

import 'package:bilbo/utils/mapKey.dart';
import 'package:bilbo/utils/request_method.dart';
import 'package:geolocator/geolocator.dart';

class UtilMethods {
  static Future<String> searchAddressForGeographicCoordinates(
      Position position, context) async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';
    String formattedAddress = '';
    var requestResponse = await RequestMethod.receiveRequest(apiUrl);

    if (requestResponse != "Something went wrong") {
      formattedAddress = requestResponse['results'][0]['formatted_address'];
    } else {
      return "Something went wrong";
    }
    return formattedAddress;
  }
}
