import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class GetUsers {
  final ProjectRepository projectRepository;

  GetUsers({required this.projectRepository});

  Future<dynamic> getUsers() async {
    return await projectRepository.getUsers();
  }
}
