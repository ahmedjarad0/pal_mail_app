import 'package:consultation_app/pages/home/custom_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'custom_action_chip.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.all(8),
                color: Colors.red,
                width: double.infinity,
                height: 50,
                child: Container(width: double.infinity));
          },
        ));
  }
}

class TagsShimmer extends StatelessWidget {
  const TagsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Wrap(
          spacing: 8,
          children: [
            const CustomActionChip(
              titleTag: 'All Tags',
            ),
            for (var i = 0; i < 6; i++) ...[
              CustomActionChip(
                titleTag: '${[i]}',
              )
            ]
          ],
        ));
  }
}

class GridShimmer extends StatelessWidget {
  const GridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GridView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.r,
                childAspectRatio: 181.w / 90.h,
                mainAxisSpacing: 16.r),
            itemBuilder: (context, index) {
              return StatusCard(
                  title: 'title', color: 0xffFFFFFF, idCount: 5.toString());
            },
            itemCount: 4,
          ),
        ));
  }
}
