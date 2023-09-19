import 'package:consultation_app/pages/home/custom_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/status_provider.dart';
import '../widgets/custom_shimmer.dart';

class ConsumerStatusProvider extends StatelessWidget {
  const ConsumerStatusProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(builder: (_, statusProvider, __) {
      if (statusProvider.state == StatusesState.Loading) {
        return const GridShimmer();
      }
      final statuses = statusProvider.statuses;

      if (statuses != null && statusProvider.state == StatusesState.Complete) {
        return Padding(
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
                  title: statuses[index].name!,
                  color: int.parse(statuses[index].color!),
                  idCount: statuses[index].mailsCount!.toString());
            },
            itemCount: statuses.length,
          ),
        );
      }
      if (statusProvider.state == StatusesState.Error) {
        return const GridShimmer();
      } else {
        return const GridShimmer();
      }
    });
  }
}
