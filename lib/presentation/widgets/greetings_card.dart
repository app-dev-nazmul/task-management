import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:technical_task/constants/app_constants.dart';
import '../../generated/assets.dart';
import '../../themes/colors.dart';

class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('dd MMM, yyyy').format(now);

    return Center(
      child: SizedBox(
        height: 58.h,
        child: Row(
          children: [
            SizedBox(
              height: 42.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 17.h,
                    child: Text(
                      AppConstants.greetingsName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.disableTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    height: 21.h,
                    child: Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Image.asset(
              Assets.imagesNotification,
              width: 24.w,
              height: 20.h,
              color: AppColors.textColor,
            ),
          ],
        ),
      ),
    );
  }
}