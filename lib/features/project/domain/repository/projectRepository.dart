import 'package:project_manager/features/project/data/models/projectModel.dart';
import 'package:project_manager/features/project/data/models/taskModel.dart';

abstract interface class ProjectRepository {
  Future<dynamic> getProjects();
  Future<dynamic> createProject(name, description, deadline);
  Future<dynamic> updateProject(ProjectModel project, id);
  Future<dynamic> deleteProject(String id);
  Future<dynamic> getUsers();
  Future<dynamic> sendEmail(List<dynamic> list);
  Future<dynamic> getUser(id);
  Future<dynamic> getTasks(id);
  Future<dynamic> updateTasks(List<TaskModel> tasks, id);
  Future<dynamic> updateTaskProgress(TaskModel task, id);
}
