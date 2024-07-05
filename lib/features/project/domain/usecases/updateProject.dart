import 'package:project_manager/features/project/data/models/projectModel.dart';
import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class UpdateProjects {
  final ProjectRepository projectRepository;

  UpdateProjects({required this.projectRepository});

  Future<dynamic> UpdateProjectu(ProjectModel project, id) async {
    return await projectRepository.updateProject(project, id);
  }
}
