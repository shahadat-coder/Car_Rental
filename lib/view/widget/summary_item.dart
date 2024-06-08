import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class summaryItem extends StatelessWidget {
  const summaryItem({
    super.key, required this.title, required this.value,
  });

  final String title,value;
  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        SizedBox(width: 10.w,),
        Text(title,),
        Spacer(),
        Text(value),
        SizedBox(width: 10.w,),
      ],
    );
  }
}