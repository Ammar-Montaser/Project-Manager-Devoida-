import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class SendEmail {
  final ProjectRepository projectRepository;

  SendEmail({required this.projectRepository});

  Future<dynamic> sendEmail(List<dynamic> list) async {
    return await projectRepository.sendEmail(list);
  }
}
