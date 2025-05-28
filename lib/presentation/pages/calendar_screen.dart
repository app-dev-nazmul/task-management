// calendar_screen.dart
import 'package:flutter/material.dart';
import 'package:technical_task/presentation/widgets/calendar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';
import '../../themes/colors.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("All task"
          ,
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
        elevation: 0,
        actions:
     [
          SizedBox(
            width: 100,
            height: 29,
            child: TextButton(

              onPressed: (){},
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFEEEFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
                padding:
                EdgeInsets
                    .zero, // Avoid internal padding interfering with fixed size
              ),
              child: Text(
                "Create New",
                style: TextStyle(
                  color:   const Color(0xFF613BE7),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
        ]
      ),

      body: Column(
        children: [
          ScrollingCalendar()
        ],
      ),
    );
  }
}