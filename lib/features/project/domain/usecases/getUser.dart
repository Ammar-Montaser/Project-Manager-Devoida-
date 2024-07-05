import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class GetUser {
  final ProjectRepository projectRepository;

  GetUser({required this.projectRepository});

  Future<dynamic> getUser(id) async {
    return await projectRepository.getUser(id);
  }
}
