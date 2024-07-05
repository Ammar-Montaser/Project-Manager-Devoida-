part of 'project_cubit.dart';

@immutable
sealed class ProjectState {}

final class ProjectInitial extends ProjectState {}

final class ProjectLoading extends ProjectState {}

final class ProjectLoaded extends ProjectState {
  final List<ProjectModel> projects;
  ProjectLoaded({required this.projects});
}

final class ProjectError extends ProjectState {
  final String message;
  ProjectError({required this.message});
}

final class UserLoaded extends ProjectState {
  final UserModel user;
  UserLoaded({required this.user});
}

final class UsersLoaded extends ProjectState {
  final List<UserModel> users;

  UsersLoaded({required this.users});
}
