import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class DeleteProject {
  final ProjectRepository projectRepository;

  DeleteProject({required this.projectRepository});

  Future<dynamic> deleteProject(id) async {
    return await projectRepository.deleteProject(id);
  }
}
