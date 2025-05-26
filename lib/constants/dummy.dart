class DummyData {
  static Map<String, int> getTaskSummary() {
    return {
      'assignedTasks': 21, // Matches Figma
      'completedTasks': 31, // Matches Figma
    };
  }

  // Dummy tasks as a list of maps for future task list implementation
  static List<Map<String, dynamic>> getTasks() {
    return [
      {
        'id': '1',
        'title': 'Design Homepage',
        'description': 'Create wireframes and mockups for the homepage.',
        'startDate': '2025-05-20',
        'endDate': '2025-05-28',
        'status': 'Assigned',
      },
      {
        'id': '2',
        'title': 'Implement Authentication',
        'description': 'Set up login and registration flows.',
        'startDate': '2025-05-15',
        'endDate': '2025-05-25',
        'status': 'Completed',
      },
      {
        'id': '3',
        'title': 'Write Unit Tests',
        'description': 'Add unit tests for the authentication module.',
        'startDate': '2025-05-22',
        'endDate': '2025-05-30',
        'status': 'Assigned',
      },
      {
        'id': '4',
        'title': 'Bug Fixing',
        'description': 'Fix reported bugs in the dashboard.',
        'startDate': '2025-05-18',
        'endDate': '2025-05-24',
        'status': 'Completed',
      },
      {
        'id': '5',
        'title': 'Database Optimization',
        'description': 'Optimize queries for better performance.',
        'startDate': '2025-05-25',
        'endDate': '2025-06-05',
        'status': 'Assigned',
      },
    ];
  }
}