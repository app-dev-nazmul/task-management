import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskSectionPage extends StatefulWidget {
  const TaskSectionPage({super.key});

  @override
  State<TaskSectionPage> createState() => _TaskSectionPageState();
}

class _TaskSectionPageState extends State<TaskSectionPage> {
  int selectedTabIndex = 0;

  // Dummy task data
  final List<TaskModel> allTasks = [
    TaskModel(
      id: 1,
      title: 'Homepage Redesign',
      description:
          'Redesign the homepage of our website to improve user engagement and align with our updated bra...',
      date: 'October 15, 2023',
      isCompleted: false,
    ),
    TaskModel(
      id: 2,
      title: 'E-commerce Checkout Process Redesign',
      description:
          'Redesign the checkout process for our e-commerce platform, focusing on improving conve...',
      date: 'December 10, 2023',
      isCompleted: true,
    ),
    TaskModel(
      id: 3,
      title: 'Mobile App Performance Optimization',
      description:
          'Optimize the performance of our mobile application to reduce loading times and improve user experience.',
      date: 'November 8, 2023',
      isCompleted: false,
    ),
    TaskModel(
      id: 4,
      title: 'API Documentation Update',
      description:
          'Update and improve our API documentation to make it more comprehensive and user-friendly for developers.',
      date: 'October 25, 2023',
      isCompleted: true,
    ),
    TaskModel(
      id: 5,
      title: 'User Authentication System',
      description:
          'Implement a secure user authentication system with multi-factor authentication support and OAuth integration.',
      date: 'November 15, 2023',
      isCompleted: false,
    ),
  ];

  List<TaskModel> get filteredTasks {
    if (selectedTabIndex == 0) {
      return allTasks; // All tasks
    } else {
      return allTasks
          .where((task) => task.isCompleted)
          .toList(); // Completed tasks
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),

            // Tab Bar
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTabIndex = 0),
                      child: Container(
                        height: 28,
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color:
                              selectedTabIndex == 0
                                  ? const Color(0xFF6366F1)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text(
                            'All tasks',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  selectedTabIndex == 0
                                      ? Colors.white
                                      : const Color(0xFF8E8E93),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTabIndex = 1),
                      child: Container(
                        height: 28,
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color:
                              selectedTabIndex == 1
                                  ? const Color(0xFF6366F1)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  selectedTabIndex == 1
                                      ? Colors.white
                                      : const Color(0xFF8E8E93),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 24),

            // Tasks List
            Expanded(
              child:
                  filteredTasks.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.task_alt,
                              size: 64,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              selectedTabIndex == 0
                                  ? 'No tasks available'
                                  : 'No completed tasks',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        padding: EdgeInsets.only(top: 12.h),

                        // Now this padding scrolls with the list
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: TaskCard(task: task),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task Title
          Text(
            task.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1D1D1F),
            ),
          ),
          const SizedBox(height: 12),

          // Task Description
          Text(
            task.description,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF8E8E93),
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),

          // Bottom Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date with icon
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: Color(0xFF8E8E93),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    task.date,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8E8E93),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color:
                      task.isCompleted
                          ? const Color(0xFFE6F7F1)
                          : const Color(0xFFE8E5FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  task.isCompleted ? 'Complete' : 'Todo',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color:
                        task.isCompleted
                            ? const Color(0xFF10B981)
                            : const Color(0xFF6366F1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Task Model
class TaskModel {
  final int id;
  final String title;
  final String description;
  final String date;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
  });
}
