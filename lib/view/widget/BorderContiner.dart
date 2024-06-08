import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class borderContiner extends StatelessWidget {
  const borderContiner({
    super.key, required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1,color: AppColors.primarycolor.withOpacity(0.25)),
          borderRadius: BorderRadius.circular(10)
      ),
      child: child,
    );
  }
}