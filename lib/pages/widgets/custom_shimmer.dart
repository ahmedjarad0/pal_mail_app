import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
