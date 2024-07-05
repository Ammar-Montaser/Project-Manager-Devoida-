import 'package:project_manager/features/project/data/models/taskModel.dart';
import 'package:project_manager/features/project/domain/repository/projectRepository.dart';

class UpdateTaskProgress {
  final ProjectRepository projectRepository;

  UpdateTaskProgress({required this.projectRepository});

  Future<dynamic> updateTaskProgress(TaskModel task, id) async {
    return await projectRepository.updateTaskProgress(task, id);
  }
}
