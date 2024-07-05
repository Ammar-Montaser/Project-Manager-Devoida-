import 'package:project_manager/features/project/data/models/taskModel.dart';
import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class UpdateTasks {
  final ProjectRepository projectRepository;

  UpdateTasks({required this.projectRepository});

  Future<dynamic> updateTasks(List<TaskModel> tasks, id) async {
    final res = await projectRepository.updateTasks(tasks, id);

    return res;
  }
}
