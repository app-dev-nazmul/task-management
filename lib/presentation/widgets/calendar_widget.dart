import 'package:flutter/material.dart';

class ScrollingCalendar extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final DateTime? selectedDate;

  const ScrollingCalendar({
    Key? key,
    this.onDateSelected,
    this.selectedDate,
  }) : super(key: key);

  @override
  State<ScrollingCalendar> createState() => _ScrollingCalendarState();
}

class _ScrollingCalendarState extends State<ScrollingCalendar> {
  late DateTime selectedDate;
  late PageController pageController;
  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate ?? DateTime.now();
    currentMonth = DateTime(selectedDate.year, selectedDate.month);

    // Start from current month (page 0 = current month)
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<DateTime> getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);

    List<DateTime> days = [];
    for (int i = 0; i < lastDay.day; i++) {
      days.add(firstDay.add(Duration(days: i)));
    }
    return days;
  }

  String getDayName(DateTime date) {
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return dayNames[date.weekday - 1];
  }

  String getShortDayName(DateTime date) {
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return dayNames[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (page) {
          setState(() {
            final now = DateTime.now();
            currentMonth = DateTime(now.year, now.month + page);
          });
        },
        itemBuilder: (context, pageIndex) {
          final now = DateTime.now();
          final month = DateTime(now.year, now.month + pageIndex);
          final daysInMonth = getDaysInMonth(month);

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daysInMonth.length,
              itemBuilder: (context, index) {
                final date = daysInMonth[index];
                final isSelected = selectedDate.year == date.year &&
                    selectedDate.month == date.month &&
                    selectedDate.day == date.day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                    widget.onDateSelected?.call(date);
                  },
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getShortDayName(date),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : const Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Usage Example
class CalendarExampleScreen extends StatefulWidget {
  @override
  State<CalendarExampleScreen> createState() => _CalendarExampleScreenState();
}

class _CalendarExampleScreenState extends State<CalendarExampleScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'All Task',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle create new task
              },
              child: const Text(
                'Create New',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6366F1),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ScrollingCalendar(
            selectedDate: selectedDate,
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
              print('Selected date: $date');
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Center(
                child: Text(
                  'Selected: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}