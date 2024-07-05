import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/features/project/data/models/taskModel.dart';
import 'package:project_manager/features/project/domain/usecases/getTasks.dart';
import 'package:project_manager/features/project/domain/usecases/updateTaskProgress.dart';
import 'package:project_manager/features/project/domain/usecases/updateTasks.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final GetTasks _getTasks;
  final UpdateTaskProgress _updateTaskProgress;
  final UpdateTasks _updateTasks;
  TasksCubit(this._getTasks, this._updateTasks, this._updateTaskProgress)
      : super(TasksInitial());

  void getTasks(id) {
    _getTasks.getTasks(id).then((value) {
      emit(TasksLoaded(tasks: value));
    });
  }

  void updateTaskProgress(TaskModel task, String? id) async {
    await _updateTaskProgress.updateTaskProgress(task, id);

    getTasks(id);
  }

  Future<void> updateTasks(List<TaskModel> tasks, String? id) async {
    await _updateTasks.updateTasks(tasks, id);
    emit(TasksLoaded(tasks: tasks));
  }
}
