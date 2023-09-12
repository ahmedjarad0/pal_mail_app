import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/helper/api_response.dart';
import '../../../provider/status_provider.dart';
class ConsumerStatusProvider extends StatelessWidget {
  const ConsumerStatusProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(builder: (_, statusProvider, __) {
      if (statusProvider.status.status == StatusCode.LOADING) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (statusProvider.status.status ==
          StatusCode.COMPLETED) {
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
              padding: EdgeInsets.symmetric(
                  vertical: 10.h, horizontal: 15.w),
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
                        backgroundColor: Color(int.parse(
                            statusProvider
                                .status.data![index].color!)),
                      ),
                      Text(
                        '${statusProvider.status.data![index].id}',
                        style: GoogleFonts.poppins(fontSize: 19.sp),
                      ),
                    ],
                  ),
                  Text(
                    statusProvider.status.data![index].name!,
                    style: GoogleFonts.poppins(fontSize: 19.sp),
                  ),
                ],
              ),
            );
          },
          itemCount: 4,
        );
      } else if (statusProvider.status.status == StatusCode.ERROR) {
        return Center(
          child: Text('${statusProvider.status.message}'),
        );
      } else {
        return const Center(
          child: Text('No data'),
        );
      }
    });
  }
}
