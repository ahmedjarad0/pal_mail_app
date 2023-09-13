import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';
class CustomActionChip extends StatelessWidget {
  const CustomActionChip({
    super.key, required this.titleTag, this.onPressed,
  });
  final String titleTag ;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ActionChip(
        label: Text(
          titleTag,
          style: Style.kTextStyle.copyWith(
              fontSize: 12, color: Colors.grey.shade600),
        ),
        backgroundColor: Colors.grey.shade200,
        disabledColor: Colors.grey.shade200,
        side: BorderSide.none,
        onPressed: onPressed,
        padding:  EdgeInsets.symmetric(
            vertical: 5.h, horizontal: 10.w),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r)));
  }
}
