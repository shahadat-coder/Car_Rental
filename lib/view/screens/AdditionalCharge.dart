import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taufiq_car_rental/Model/customerModel.dart';
import 'package:taufiq_car_rental/view/utils/app_colors.dart';

import '../../Model/reservation_model.dart';
import '../widget/BorderContiner.dart';
import '../widget/screenTitle.dart';
import 'Summary.dart';

class AdditionalCharge extends StatefulWidget {
  const AdditionalCharge(
      {Key? key,
      required this.reservationList,
      required this.customerInfo,
      required this.selectedcar})
      : super(key: key);

  final List<ReservationModel> reservationList;
  final List<dynamic> selectedcar;
  final List<CustomerInfo> customerInfo;

  @override
  State<AdditionalCharge> createState() => _AdditionalChargeState();
}

class _AdditionalChargeState extends State<AdditionalCharge> {
  List<bool> _isCheckedList = [false, false, false];
  String _currText = '';
  int _selectedIndex = -1;

  List<Map<String, dynamic>> selectedcharge = [];

  List<Map<String, dynamic>> options = [
    {'name': 'Collision Damage Waiver', 'price': '9.00'},
    {'name': 'Liability Insurance', 'price': '15.00'},
    {'name': 'Rental Tax', 'price': '11.5'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 56, // Adjust the height as needed
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Back",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            ScreenTitle(
              title: 'Additional Charges',
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: borderContiner(
                child:  Column(
                  children: options.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> option = entry.value;
                    String name = option['name'];
                    dynamic price = option['price'];
                    return RadioListTile<int>(
                      title: Row(
                        children: [
                          Text(
                            '$name',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Spacer(),
                          Text(
                            '\$ $price',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      value: index,
                      groupValue: _selectedIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedIndex = value!;
                          _currText = name;
                          selectedcharge.clear();
                          selectedcharge.add({'name': name, 'price': price});
                          print('selected additional ==== $selectedcharge');
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Center(
              child: SizedBox(
                  height: 30.h,
                  width: 150.w,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(Summary(
                          reservationList: widget.reservationList,
                          selectedcar: widget.selectedcar,
                          customerInfo: widget.customerInfo,
                          selectedaditional: selectedcharge,
                        ));
                      },
                      child: Text('Next'))),
            )
          ],
        ),
      ),
    );
  }
}
