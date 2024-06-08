import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data/utils/urls.dart';

class CarController extends GetxController {
  List<dynamic> cardata = [];

  Future<void> fetchCarData() async {
    try {
      final response = await http.get(Uri.parse(Urls.car_list));
      if (response.statusCode == 200) {
        cardata = json.decode(response.body)['data'];

        log(cardata.toString());
        update();
      } else {
        log(response.body.toString());
      }
    } catch (e) {
      log('Error fetching data: $e');
    }
  }
}
