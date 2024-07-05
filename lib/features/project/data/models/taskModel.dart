class TaskModel {
  final String id;
  final String name;
  final String description;
  String status;
  final List asignedToId;
  final String projectId;
  final String deadline;

  TaskModel(
      {required this.id,
      required this.deadline,
      required this.description,
      required this.name,
      required this.projectId,
      required this.status,
      required this.asignedToId});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'deadline': deadline,
      'asignedToId': asignedToId,
      'projectId': projectId
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json, i) {
    print(json["tasks"]);
    return TaskModel(
      id: json['id'],
      deadline: json['deadline'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      asignedToId: json['asignedToId'],
      projectId: json['projectId'],
    );
  }
}
