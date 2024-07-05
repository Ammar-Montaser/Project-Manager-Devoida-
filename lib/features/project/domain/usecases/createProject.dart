import 'package:project_manager/features/project/data/models/projectModel.dart';
import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class CreateProject {
  final ProjectRepository projectRepository;

  CreateProject({required this.projectRepository});

  Future<dynamic> createProject(name, description, deadline) async {
    return await projectRepository.createProject(name, description, deadline);
  }
}
