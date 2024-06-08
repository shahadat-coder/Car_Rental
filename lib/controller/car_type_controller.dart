import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data/utils/urls.dart';

class CarTypeController extends GetxController {
  List<String> carTypes = []; // List to store car types

  Future<void> fetchCarData() async {
    try {
      final response = await http.get(Uri.parse(Urls.car_list));
      if (response.statusCode == 200) {
        List<dynamic> carData = json.decode(response.body)['data'];

        carTypes = carData
            .map((car) => car['type'])
            .whereType<String>() // Filter out non-string values
            .toSet() // Convert to set to remove duplicates
            .toList(); // Convert back to list

        log(carTypes.toString());
        update();
      } else {
        log(response.body.toString());
      }
    } catch (e) {
      log('Error fetching data: $e');
    }
  }
}
