import 'dart:convert';


import 'package:exercise2/model/restaurant.dart';
import 'package:exercise2/service/restaurant_service.dart';

class RestaurantController {
  final RestaurantService _restaurantService = RestaurantService();

  Future<Map<String, dynamic>> addRestaurant(Restaurant tempat) async {
    Map<String, String> data = {
      'nama': tempat.nama,
      'alamat': tempat.alamat,
      'no_telepon': tempat.telepon,
      'review': tempat.review,
    };

    try {
      var response = await _restaurantService.addRestaurant(data);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Data berhasil disimpan',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'Terjadi kesalahan',
          };
        }
        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi kesalahan saat menyimpan data'
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<List<Restaurant>> getRestaurant() async {
    try {
      List<dynamic> restaurantData = await _restaurantService.fetchPeople();
      if (restaurantData != null) {
        List<Restaurant> people =
            restaurantData.map((json) => Restaurant.fromMap(json)).toList();
        return people;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get people: $e');
    }
  }
}
