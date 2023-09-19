import 'package:consultation_app/pages/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/tag_provider.dart';
import '../widgets/custom_action_chip.dart';

class ConsumerTags extends StatelessWidget {
  const ConsumerTags({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
      child: Consumer<TagProvider>(
        builder: (context, tagProvider, child) {
          if (tagProvider.statues == TagStatues.Loading) {
            return const TagsShimmer();
          }
          final tags = tagProvider.tag;
          if (tags != null && tagProvider.statues == TagStatues.Complete) {
            return Wrap(
              spacing: 8,
              children: [
                const CustomActionChip(
                  titleTag: 'All Tag',
                ),
                for (int i = 0; i < tags.length; i++) ...[
                  CustomActionChip(titleTag: tags[i].name!),
                ]
              ],
            );
          }
          if (tagProvider.statues == TagStatues.Error) {
            return const TagsShimmer();
          } else {
            return const TagsShimmer();
          }
        },
      ),
    );
  }
}
