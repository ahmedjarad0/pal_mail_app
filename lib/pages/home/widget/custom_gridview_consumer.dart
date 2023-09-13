import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/status_provider.dart';

class ConsumerStatusProvider extends StatelessWidget {
  const ConsumerStatusProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(builder: (_, statusProvider, __) {
      if (statusProvider.state == StatusesState.Loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      final statuses = statusProvider.statuses;

      if (statuses != null && statusProvider.state == StatusesState.Loaded) {
        return GridView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.r,
              childAspectRatio: 181.w / 90.h,
              mainAxisSpacing: 16.r),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5.h),
                      blurRadius: 3.sp)
                ],
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 10.r,
                        backgroundColor:
                            Color(int.parse(statuses[index].color!)),
                      ),
                      Text(
                        '${statuses[index].id}',
                        style: GoogleFonts.poppins(fontSize: 19.sp),
                      ),
                    ],
                  ),
                  Text(
                    statuses[index].name!,
                    style: GoogleFonts.poppins(fontSize: 19.sp),
                  ),
                ],
              ),
            );
          },
          itemCount: statuses.length,
        );
      }
      if (statusProvider.state == StatusesState.Error) {
        return Center(
          child: Text(statusProvider.state.name),
        );
      } else {
        return const Center(
          child: Text('No data'),
        );
      }
    });
  }
}
