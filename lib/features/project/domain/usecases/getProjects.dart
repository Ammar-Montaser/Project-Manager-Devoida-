import 'package:project_manager/features/project/data/models/projectModel.dart';
import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class GetProjects {
  final ProjectRepository projectRepository;

  GetProjects({required this.projectRepository});

  Future<dynamic> getProjects() async {
    return await projectRepository.getProjects();
  }
}
