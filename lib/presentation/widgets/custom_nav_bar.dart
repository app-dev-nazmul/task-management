import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Make sure this is imported
import '../../constants/bottom_menu.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25), // Equivalent to alpha: 0.1 * 255
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Row(
          children: List.generate(bottomNavItems.length, (index) {
            final item = bottomNavItems[index];
            final isActive = index == currentIndex;

            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFFF0F2F8) : Colors.transparent,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Image.asset(
                      item.assetPath,
                      height: 24.h,
                      width: 24.w,
                      color: isActive ? const Color(0xFF613BE7) : Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}