import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTitle extends StatelessWidget {
  const InputTitle({
    super.key, required this.title, required this.isrequried,
  });

  final String title;
  final bool isrequried;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,),
        SizedBox(width: 3.w,),
        isrequried ? Text('*',style: TextStyle(color: Colors.red),) : SizedBox(),
      ],
    );
  }
}