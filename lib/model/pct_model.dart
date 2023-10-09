import 'dart:convert';

class PctModel {
  int? id;
  String name;
  bool isOnline;
  List<dynamic> tasks;
  int? maxTask;

  PctModel({
    required this.id,
    required this.name,
    required this.isOnline,
    required this.tasks,
    required this.maxTask,
  });

  PctModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        isOnline = json['is_online'],
        tasks = json['tasks'],
        maxTask = json['max_task'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'is_online': isOnline,
    'tasks': tasks,
    'max_task': maxTask,
  };
  @override
  String toString() => json.encode(this);
}
