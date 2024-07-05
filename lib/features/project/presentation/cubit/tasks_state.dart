part of 'tasks_cubit.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class TasksLoaded extends TasksState {
  final List<TaskModel> tasks;
  TasksLoaded({required this.tasks});
}

final class TasksError extends TasksState {
  final String message;
  TasksError({required this.message});
}

final class TaskUpdated extends TasksState {}

final class TasksLoading extends TasksState {}
