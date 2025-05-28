import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:technical_task/constants/app_constants.dart';
import 'package:technical_task/routes/app_router.dart';
import '../../../domain/entities/task_entity.dart';
import '../../routes/app_routes.dart';
import '../provider/task_provider.dart';

class TaskSectionPage extends ConsumerStatefulWidget {
  const TaskSectionPage({super.key});

  @override
  ConsumerState<TaskSectionPage> createState() => _TaskSectionPageState();
}

class _TaskSectionPageState extends ConsumerState<TaskSectionPage> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final taskList = ref.watch(taskControllerProvider);

    final filteredTasks = selectedTabIndex == 0
        ? taskList
        : taskList.where((task) => task.status.toLowerCase() == 'completed').toList();

    return Scaffold(
    backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppConstants.todayTask,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
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
                            AppConstants.allTask,
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
                            AppConstants.statusCompleted,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: selectedTabIndex == 1
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
                                  ? AppConstants.noTaskAvailable
                                  : AppConstants.noCompletedTask,
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
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          return Padding(
                            padding:  EdgeInsets.only(bottom: 16),
                            child: GestureDetector(child: TaskCard(task: task),onTap: (){
                              AppRouter.router.go(
                                AppRoutes.viewTask,
                                extra: {
                                  'task': task,
                                  'isEditMode': true,
                                },
                              );
                            },),
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
  final TaskEntity task;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: Color(0xFF8E8E93),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat('MMMM d, y').format(DateTime.parse(task.createdAt)),
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
                      task.status == AppConstants.statusCompletedStor
                          ? const Color(0xFFE6F7F1)
                          : const Color(0xFFE8E5FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  task.status == AppConstants.statusCompletedStor ? AppConstants.statusCompleted: AppConstants.statusTodoStore,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color:
                    task.status == AppConstants.statusCompletedStor
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
