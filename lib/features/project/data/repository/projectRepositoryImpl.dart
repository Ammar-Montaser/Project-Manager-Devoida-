import 'package:project_manager/features/auth/data/models/userModel.dart';
import 'package:project_manager/features/project/data/dataSources/projectsRemoteDB.dart';
import 'package:project_manager/features/project/data/models/projectModel.dart';
import 'package:project_manager/features/project/data/models/taskModel.dart';
import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectsRemoteDB projectsRemoteDB;

  ProjectRepositoryImpl({required this.projectsRemoteDB});

  @override
  Future createProject(name, description, deadline) {
    return projectsRemoteDB.createProject(ProjectModel(
        name: name,
        createdAt: DateTime.now(),
        deadline: deadline,
        description: description,
        progress: 0.0,
        id: ''));
  }

  @override
  Future deleteProject(String id) {
    return projectsRemoteDB.deleteProject(id);
  }

  @override
  Future getProjects() {
    return projectsRemoteDB.getProjects();
  }

  @override
  Future updateProject(ProjectModel project, id) {
    return projectsRemoteDB.updateProject(project, id);
  }

  @override
  Future getUsers() {
    return projectsRemoteDB.getUsers();
  }

  @override
  Future updateTasks(List<TaskModel> tasks, id) {
    return projectsRemoteDB.updateTasks(tasks, id);
  }

  @override
  Future getTasks(id) {
    return projectsRemoteDB.getTasks(id);
  }

  @override
  Future getUser(id) {
    return projectsRemoteDB.getUser(id);
  }

  @override
  Future updateTaskProgress(TaskModel task, id) {
    return projectsRemoteDB.updateTaskProgress(task, id);
  }
}
