import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_manager/features/auth/data/models/userModel.dart';
import 'package:project_manager/features/project/data/models/projectModel.dart';
import 'package:project_manager/features/project/data/models/taskModel.dart';
import 'package:project_manager/features/project/domain/usecases/createProject.dart';
import 'package:project_manager/features/project/domain/usecases/deleteProject.dart';
import 'package:project_manager/features/project/domain/usecases/getProjects.dart';
import 'package:project_manager/features/project/domain/usecases/getTasks.dart';
import 'package:project_manager/features/project/domain/usecases/getUser.dart';
import 'package:project_manager/features/project/domain/usecases/getUsers.dart';
import 'package:project_manager/features/project/domain/usecases/updateProject.dart';
import 'package:project_manager/features/project/domain/usecases/updateTasks.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final GetProjects _getProjects;
  final CreateProject _createProject;
  final UpdateProjects _updateProject;
  final DeleteProject _deleteProject;
  final GetUsers _getUsers;
  final GetUser _getUser;

  ProjectCubit(
    this._getProjects,
    this._createProject,
    this._updateProject,
    this._deleteProject,
    this._getUsers,
    this._getUser,
  ) : super(ProjectInitial());

  void getProjects() {
    _getProjects.getProjects().then((value) {
      emit(ProjectLoaded(projects: value));
    });
  }

  void getUsers() {
    _getUsers.getUsers().then((value) {
      emit(UsersLoaded(users: value));
    });
  }

  void getUser(id) {
    _getUser.getUser(id).then((value) {
      emit(UserLoaded(user: value));
    });
  }

  void createProject(name, description, deadline) {
    _createProject.createProject(
      name,
      description,
      deadline,
    );
    var updatedList = _getProjects
        .getProjects()
        .then((value) => emit(ProjectLoaded(projects: value)));
  }

  void updateProject(project, id) {
    _updateProject.UpdateProjectu(project, id).then((value) {
      emit(ProjectLoaded(projects: value));
    });
  }

  void deleteProject(id) {
    _deleteProject.deleteProject(id).then((value) {
      emit(ProjectLoaded(projects: value));
    });
  }
}
