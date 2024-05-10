import 'dart:convert';

import 'package:http/http.dart' as http;

class RestaurantService {
  final String baseUrl = 'https://paml.tatiumy.com/api/';
  final String endPoint = 'people';

  Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }

  Future<http.Response> addRestaurant(Map<String, String> data) async {
    var response = await http.post(getUri(endPoint),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(data));

    return response;
  }

  Future<List<dynamic>> fetchPeople() async {
    try {
      var response = await http.get(
        getUri(endPoint),
        headers: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        return decodedResponse['restaurant'];
      } else {
        throw Exception('Failed to load restaurant: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list instead of null
    }
  }
}
