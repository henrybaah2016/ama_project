import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class RequestMethod {
  static Future<dynamic> receiveRequest(String url) async {
    Map<String, String> header = {
      'Access-Control-Allow-Origin': '*', // Required for CORS support to work
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "GET,POST, OPTIONS"
    };
    http.Response httpResponse =
        await http.get(Uri.parse(url), headers: header);

    try {
      if (httpResponse.statusCode == 200) {
        String responseData = httpResponse.body; //in json format

        var decodeResponseData = json.decode(responseData);
        return decodeResponseData;
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      print(e);
      return "Something went wrong";
    }
  }
}
