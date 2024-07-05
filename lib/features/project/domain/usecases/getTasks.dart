import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class GetTasks {
  final ProjectRepository projectRepository;

  GetTasks({required this.projectRepository});

  Future<dynamic> getTasks(id) async {
    return await projectRepository.getTasks(id);
  }
}
