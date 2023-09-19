import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShowModelBottom extends StatefulWidget {
  const CustomShowModelBottom({
    super.key,
    required this.builder,
    this.childModel,
  });

  final Widget Function(BuildContext, ScrollController) builder;

  final Widget? childModel;

  @override
  State<CustomShowModelBottom> createState() => _CustomShowModelBottomState();
}

class _CustomShowModelBottomState extends State<CustomShowModelBottom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            useSafeArea: true,
            isDismissible: false,
            clipBehavior: Clip.antiAlias,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.r),
              ),
            ),
            context: context,
            builder: (context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.99,
                maxChildSize: 0.99,
                minChildSize: 0.99,
                snap: false,
                expand: true,
                builder: widget.builder,
              );
            },
          );
        },
        child: widget.childModel);
  }
}
