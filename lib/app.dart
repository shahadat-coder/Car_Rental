import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taufiq_car_rental/view/screens/home.dart';
import 'package:get/get.dart';
import 'package:taufiq_car_rental/view/utils/app_colors.dart';

import 'controller/car_controller.dart';
import 'controller/car_type_controller.dart';

class Car_Rental extends StatefulWidget {
  static GlobalKey<ScaffoldState> globalKey = GlobalKey();
  const Car_Rental({super.key});

  @override
  State<Car_Rental> createState() => _Car_RentalState();
}

class _Car_RentalState extends State<Car_Rental> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 640),
        builder: (context, child) => GetMaterialApp(
              theme: ThemeData(
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primarycolor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              key: Car_Rental.globalKey,
              debugShowCheckedModeBanner: false,
              title: 'Car Rental',
              home: HomeScreen(),
              initialBinding: ControllerBinding(),
            ));
  }
}

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CarController());
    Get.put(CarTypeController());
  }
}
