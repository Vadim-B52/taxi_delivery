import 'task_to.dart';

class GetTasksResponseTO {
  final String summary;
  final List<TaskTO> tasks;

  GetTasksResponseTO({this.summary, this.tasks});

  factory GetTasksResponseTO.fromJson(Map<String, dynamic> json) =>
      GetTasksResponseTO(
          summary: json['summary'] as String,
          tasks: json['tasks']
              .cast<Map<String, dynamic>>()
              .map<TaskTO>((json) => TaskTO.fromJson(json))
              .toList());
}
