import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Model/reservation_model.dart';
import '../utils/app_colors.dart';
import '../widget/BorderContiner.dart';
import '../widget/inputtitle.dart';
import '../widget/screenTitle.dart';
import 'customer_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController reservation_id = TextEditingController();
  TextEditingController pickup_date = TextEditingController();
  TextEditingController return_date = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController discount = TextEditingController();
  bool selectedpickup = false;
  bool selectedreturn = false;
  DateTime _pickupDateTime = DateTime.now();
  DateTime _returnDateTime = DateTime.now();
  String _durationText = '';
  List<ReservationModel> reservationList = [];
  int ? week;
  int ? day;



  Future<void> _selectPickupDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _pickupDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _pickupDateTime) {
      setState(() {
        _pickupDateTime = picked;
        selectedpickup = true;
      });
      _calculateDuration();
    }
  }

  Future<void> _selectPickupTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_pickupDateTime),
    );
    if (picked != null) {
      setState(() {
        _pickupDateTime = DateTime(
          _pickupDateTime.year,
          _pickupDateTime.month,
          _pickupDateTime.day,
          picked.hour,
          picked.minute,
        );
        selectedpickup = true;
      });
      _calculateDuration();
    }
  }

  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _returnDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _returnDateTime) {
      setState(() {
        _returnDateTime = picked;
        selectedreturn = true;
      });
      _calculateDuration();
    }
  }

  ReservationModel reservationModel = ReservationModel(
      reservation_id: '',
      pickupdate: DateTime.now(),
      returndate: DateTime.now(),
      discount: '', week:0, day:0 );

  Future<void> _selectReturnTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_returnDateTime),
    );
    if (picked != null) {
      setState(() {
        _returnDateTime = DateTime(
          _returnDateTime.year,
          _returnDateTime.month,
          _returnDateTime.day,
          picked.hour,
          picked.minute,
        );
        selectedreturn = true;
        print('return pick ===${selectedreturn}');
      });
      _calculateDuration();
    }
  }

  void _calculateDuration() {
    Duration duration = _returnDateTime.difference(_pickupDateTime);
    int weeks = duration.inDays ~/ 7;
    int remainingDays = duration.inDays % 7;
    setState(() {
      _durationText = '$weeks weeks and $remainingDays days';
      week = weeks;
      day = remainingDays;
    });
    print('count ${week} count ${day}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              ScreenTitle(
                title: 'Reservation Details',
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: borderContiner(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputTitle(
                          title: 'Reservation ID',
                          isrequried: true,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 35.h,
                          child: TextFormField(
                            controller: reservation_id,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide(
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
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter your Reservation Id';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        InputTitle(
                          title: 'Pickup Date',
                          isrequried: true,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),

                        //taking pickup date time with bottomSheet

                        InkWell(
                          onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 150.h,
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Select Pickup Date & Time',
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () =>
                                                  _selectPickupDate(context),
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Select Date',
                                                ),
                                                child: Text(
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(_pickupDateTime),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () =>
                                                  _selectPickupTime(context),
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Select Time',
                                                ),
                                                child: Text(
                                                  DateFormat('HH:mm')
                                                      .format(_pickupDateTime),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          child: SizedBox(
                            height: 35.h,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  selectedpickup
                                      ? Text(
                                          DateFormat('yyyy-MM-dd, HH:MM')
                                              .format(_pickupDateTime),
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      : Text(
                                          'Select Day and Time',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                  Spacer(),
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey.shade400,
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade300)),
                            ),
                          ),
                        ),

                        //end pickup date

                        SizedBox(
                          height: 15.h,
                        ),
                        // return date start

                        InputTitle(
                          title: 'Returen Date',
                          isrequried: true,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),

                        //taking return date time with bottomSheet

                        InkWell(
                          onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 150.h,
                                  padding: EdgeInsets.all(16.0),
                                  child: StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Select Return Date & Time',
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () =>
                                                    _selectReturnDate(context),
                                                child: InputDecorator(
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Select Date',
                                                  ),
                                                  child: Text(
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(
                                                            _returnDateTime),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () =>
                                                    _selectPickupTime(context),
                                                child: InputDecorator(
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Select Time',
                                                  ),
                                                  child: Text(
                                                    DateFormat('HH:mm').format(
                                                        _returnDateTime),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                                );
                              }),
                          child: SizedBox(
                            height: 35.h,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  selectedreturn
                                      ? Text(
                                          DateFormat('yyyy-MM-dd, HH:MM')
                                              .format(_returnDateTime),
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      : Text(
                                          'Select Day and Time',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                  Spacer(),
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey.shade400,
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade300)),
                            ),
                          ),
                        ),

                        //end pickup date
                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InputTitle(
                              title: 'Duration',
                              isrequried: false,
                            ),
                            Spacer(),
                            Container(
                              child: Center(
                                child: Text(_durationText,
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.grey)),
                              ),
                              height: 30.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade300)),
                            ),
                            Spacer(),
                          ],
                        ),

                        SizedBox(
                          height: 15.h,
                        ),

                        InputTitle(
                          title: 'Discount',
                          isrequried: false,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 35.h,
                          child: TextFormField(
                            controller: discount,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide: BorderSide(
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
                      ],
                    ),
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
                          if (reservation_id.text == '') {
                            Get.snackbar(
                                'Warning', 'Please Fill up Reservation ID');
                          } else if (!selectedpickup) {
                            Get.snackbar(
                                'Warning', 'Please Fill up pickup date');
                          } else if (!selectedreturn) {
                            Get.snackbar(
                                'Warning', 'Please Fill up return date');
                          } else {
                            ReservationModel reservationModel = ReservationModel(
                              reservation_id: reservation_id.text.trim(),
                              pickupdate: _pickupDateTime,
                              returndate: _returnDateTime,

                              discount: discount.text.trim(), week: week ?? 0, day: day ?? 0,
                            );
                            reservationList.add(reservationModel);
                            print('reservation data ===== ${reservationList}');
                            Get.to(CustomerInformation(reservationList:reservationList));
                          }
                        },
                        child: Text('Next'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
