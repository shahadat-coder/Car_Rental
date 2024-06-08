import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class ScreenTitle extends StatefulWidget {
  const ScreenTitle({
    super.key, required this.title,

  });

  final String title;

  @override
  State<ScreenTitle> createState() => _ScreenTitleState();
}

class _ScreenTitleState extends State<ScreenTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.00),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h,),
          Text(widget.title,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600)),
          SizedBox(height: 5.h,),
          Container(height: 1.h,width: 100.sw,color: AppColors.primarycolor)
        ],
      ),
    );
  }
}

