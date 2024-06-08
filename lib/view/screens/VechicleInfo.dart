import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Model/customerModel.dart';
import '../../Model/reservation_model.dart';
import '../../controller/car_controller.dart';
import '../../controller/car_type_controller.dart';
import '../utils/app_colors.dart';
import '../widget/BorderContiner.dart';
import '../widget/inputtitle.dart';
import '../widget/screenTitle.dart';
import 'AdditionalCharge.dart';

class VechicleInfo extends StatefulWidget {
  const VechicleInfo(
      {Key? key, required this.reservationList, required this.customerInfo})
      : super(key: key);

  final List<ReservationModel> reservationList;
  final List<CustomerInfo> customerInfo;

  @override
  State<VechicleInfo> createState() => _VechicleInfoState();
}

class _VechicleInfoState extends State<VechicleInfo> {
  CarTypeController carTypeController = Get.put(CarTypeController());
  CarController carController = Get.put(CarController());
  final TextEditingController modelController = TextEditingController();

  List<dynamic> selectedCar = [];

  @override
  void initState() {
    super.initState();
    carTypeController.fetchCarData();
    carController.fetchCarData();
    log(carController.cardata.toString());
  }

  String selectedVehicleType = '';
  late List<String> vehicleTypes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 56, // Adjust the height as needed
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Back",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              const ScreenTitle(
                title: 'Vehicle Information',
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    borderContiner(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 15.0, right: 15),
                        child: Column(
                          children: [
                            // Vehicle Type input section start

                            const InputTitle(
                              title: 'Vehicle Type',
                              isrequried: true,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            GetBuilder<CarTypeController>(
                              builder: (controller) {
                                return SizedBox(
                                  height: 35.h,
                                  child: DropdownButtonFormField2<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    items: controller.carTypes
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select type';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      selectedVehicleType = value.toString();
                                      setState(() {
                                        selectedVehicleType = value ?? '';
                                      });
                                      print(
                                          'selected typeee ===== ${selectedVehicleType}');
                                    },
                                    onSaved: (value) {},
                                    buttonStyleData: const ButtonStyleData(
                                      padding: EdgeInsets.only(right: 8),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 24,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                    ),
                                  ),
                                );
                              },
                            ),

                            SizedBox(
                              height: 15.h,
                            ),

                            //Vehicle Type input end

                            //Vehicle Model input start

                            const InputTitle(
                              title: 'Vehicle Model',
                              isrequried: true,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 35.h,
                              child: TextFormField(
                                onSaved: (value) {
                                  modelController.text = value!;
                                  setState(() {});
                                },
                                onChanged: (value) {},
                                controller: modelController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    color: AppColors.primarycolor,
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.search),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: const BorderSide(
                                      color: AppColors.primarycolor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),

                            //Vehicle Model input end
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    //Car card start

                    GetBuilder<CarController>(builder: (controller) {
                      print('model dataaa ==== ${modelController.text}');

                      List filteredData = selectedVehicleType.isNotEmpty
                          ? controller.cardata
                              .where(
                                  (car) => car['type'] == selectedVehicleType)
                              .toList()
                          : List.from(controller.cardata);

                      List filteredData2 = modelController.text.isNotEmpty
                          ? filteredData
                              .where((car) =>
                                  car['type'] == selectedVehicleType &&
                                  car['model'] == modelController.text)
                              .toList()
                          : List.from(filteredData);

                      return Container(
                        height: 260.h,
                        width: 100.sw,
                        child: ListView.builder(
                            itemCount: filteredData2.length,
                            itemBuilder: (context, index) {
                              final car = filteredData2[index];
                              final bool isSelected = selectedCar.contains(car);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedCar.remove(car);
                                      } else {
                                        selectedCar.add(car);
                                        print('Navigating to AdditionalCharge page...');
                                        Get.to(AdditionalCharge(
                                          reservationList: widget.reservationList,
                                          customerInfo: widget.customerInfo,
                                          selectedcar: selectedCar,
                                        ));
                                      }
                                    });
                                    print('Car selected: $selectedCar');
                                  },

                                  child: borderContiner(
                                    child: Container(
                                      color: isSelected
                                          ? AppColors.primarycolor
                                              .withOpacity(0.25)
                                          : Colors.white,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.network(
                                                car['imageURL'],
                                                height: 100.h,
                                                width: 200.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        car['make'],
                                                        style: TextStyle(
                                                            fontSize: 17.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        width: 4.w,
                                                      ),
                                                      Text(
                                                        car['model'],
                                                        style: TextStyle(
                                                            fontSize: 17.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.people,
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        '${car['seats']} Seat',
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .shopping_bag_rounded,
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        '${car['bags']} bags',
                                                        style: const TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              Text(
                                                '\$${car['rates']['hourly']} / Hour',
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              const Spacer(),
                                              Text(
                                                '\$${car['rates']['daily']} / Day',
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              const Spacer(),
                                              Text(
                                                '\$${car['rates']['weekly']} / Week',
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: SizedBox(
                    height: 30.h,
                    width: 150.w,
                    child: ElevatedButton(
                        onPressed: () {
                          if(selectedCar.isNotEmpty){
                            Get.to(AdditionalCharge(
                              reservationList: widget.reservationList,
                              customerInfo: widget.customerInfo,
                              selectedcar: selectedCar,
                            ));
                          }else{
                            Get.snackbar('Warning', 'Please select Car');
                          }

                        },
                        child: const Text('Next'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
