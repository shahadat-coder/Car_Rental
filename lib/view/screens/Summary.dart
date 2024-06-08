import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../Model/customerModel.dart';
import '../../Model/reservation_model.dart';
import '../utils/app_colors.dart';
import '../widget/BorderContiner.dart';
import '../widget/screenTitle.dart';
import '../widget/summary_item.dart';

class Summary extends StatefulWidget {
  const Summary(
      {super.key,
      required this.reservationList,
      required this.selectedcar,
      required this.customerInfo,
      required this.selectedaditional});

  final List<ReservationModel> reservationList;
  final List<dynamic> selectedcar;
  final List<CustomerInfo> customerInfo;
  final List<Map<String, dynamic>> selectedaditional;
  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  late int countweek;
  late int countday;
  late int additionalcharge;
  late int carweekprice;
  late int cardayprice;
  late int finalweekprice;
  late int finaldayprice;
  late int totalprice;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countweek = widget.reservationList.first.week;
    countday = widget.reservationList.first.day;
    additionalcharge =
        double.parse(widget.selectedaditional.first['price']).toInt();
    carweekprice = widget.selectedcar.first['rates']['weekly'] as int;
    cardayprice = widget.selectedcar.first['rates']['daily'] as int;
    finalweekprice = countweek * carweekprice;
    finaldayprice = countday * cardayprice;
    totalprice = finalweekprice + finaldayprice + additionalcharge;

    print('reservation dataaa ==== ${widget.reservationList.first.pickupdate}');
  }

  @override
  Widget build(BuildContext context) {

    DateTime pickupdate = widget.reservationList.first.pickupdate;
    DateTime returndate = widget.reservationList.first.returndate;
    DateFormat dateFormat = DateFormat('h:mm a, d MMMM yyyy');
    String formattedpickup = dateFormat.format(pickupdate);
    String formattedreturn = dateFormat.format(returndate);

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                //Reservation section start

                SizedBox(
                  height: 10.h,
                ),
                ScreenTitle(
                  title: 'Reservation Details',
                ),
                SizedBox(
                  height: 10.h,
                ),
                borderContiner(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      summaryItem(
                        title: 'Reservation ID',
                        value: widget.reservationList.first.reservation_id,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      summaryItem(
                        title: 'Pickup Date',
                        value:
                        formattedpickup,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      summaryItem(
                        title: 'Dropoff Date',
                        value:
                        formattedreturn,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
                //Reservation section end

                //customer section start

                SizedBox(
                  height: 10.h,
                ),
                ScreenTitle(
                  title: 'Customer Information',
                ),
                SizedBox(
                  height: 10.h,
                ),
                borderContiner(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      summaryItem(
                        title: 'First Name',
                        value: widget.customerInfo.first.firstName,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      summaryItem(
                        title: 'Last name',
                        value: widget.customerInfo.first.lastName,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      summaryItem(
                        title: 'Email',
                        value: widget.customerInfo.first.email,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      summaryItem(
                        title: 'phone',
                        value: widget.customerInfo.first.phone,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),

                //customer section end

                //vehicle section start

                SizedBox(
                  height: 10.h,
                ),
                ScreenTitle(
                  title: 'Vehicle Information',
                ),
                SizedBox(
                  height: 10.h,
                ),
                borderContiner(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      summaryItem(
                        title: 'Vehicle Type',
                        value: widget.selectedcar.first['type'],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      summaryItem(
                        title: 'Vehicle Model',
                        value: widget.selectedcar.first['model'],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
                //vehicle section end

                //Charge Summary

                SizedBox(
                  height: 10.h,
                ),

                ScreenTitle(
                  title: 'Charges Summary',
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.primarycolor.withOpacity(0.1),
                      border:
                          Border.all(width: 1, color: AppColors.primarycolor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12, bottom: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Charge',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              'Total',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 2.h,
                          width: 100.sw,
                          color: AppColors.primarycolor.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        summaryItem(
                          title: 'Weekly (${countweek} week) ',
                          value: '\$${finalweekprice}',
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        summaryItem(
                          title: 'Daily (${countday} day) ',
                          value: '\$${finaldayprice}',
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        summaryItem(
                          title: widget.selectedaditional.first['name'],
                          value: '\$${widget.selectedaditional.first['price']}',
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Net Total',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              '\$${totalprice}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
