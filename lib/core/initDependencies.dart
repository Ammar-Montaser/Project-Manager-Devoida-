import 'package:get_it/get_it.dart';
import 'package:project_manager/features/auth/data/dataSources/authRemoteDB.dart';
import 'package:project_manager/features/auth/data/repository/authRepositoryImpl.dart';
import 'package:project_manager/features/auth/domain/repository/auth_repository.dart';
import 'package:project_manager/features/auth/domain/usecases/login.dart';
import 'package:project_manager/features/auth/domain/usecases/register.dart';
import 'package:project_manager/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:project_manager/features/project/data/dataSources/projectsRemoteDB.dart';
import 'package:project_manager/features/project/data/repository/projectRepositoryImpl.dart';
import 'package:project_manager/features/project/domain/repository/projectRepository.dart';
import 'package:project_manager/features/project/domain/usecases/createProject.dart';
import 'package:project_manager/features/project/domain/usecases/deleteProject.dart';
import 'package:project_manager/features/project/domain/usecases/getProjects.dart';
import 'package:project_manager/features/project/domain/usecases/getTasks.dart';
import 'package:project_manager/features/project/domain/usecases/getUser.dart';
import 'package:project_manager/features/project/domain/usecases/getUsers.dart';
import 'package:project_manager/features/project/domain/usecases/updateProject.dart';
import 'package:project_manager/features/project/domain/usecases/updateTaskProgress.dart';
import 'package:project_manager/features/project/domain/usecases/updateTasks.dart';
import 'package:project_manager/features/project/presentation/cubit/project_cubit.dart';
import 'package:project_manager/features/project/presentation/cubit/tasks_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initProjects();
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDB>(() => AuthRemoteDBImpl());
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDB: serviceLocator()));
  serviceLocator
      .registerFactory(() => UserRegister(authRepository: serviceLocator()));

  serviceLocator
      .registerFactory(() => UserLogin(authRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => AuthCubit(serviceLocator(), serviceLocator()));
}

void _initProjects() {
  serviceLocator
      .registerFactory<ProjectsRemoteDB>(() => ProjectsRemoteDBImpl());
  serviceLocator.registerFactory<ProjectRepository>(
      () => ProjectRepositoryImpl(projectsRemoteDB: serviceLocator()));
  serviceLocator.registerFactory(
      () => CreateProject(projectRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => DeleteProject(projectRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => GetProjects(projectRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => UpdateProjects(projectRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => GetUsers(projectRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => UpdateTasks(projectRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => GetTasks(projectRepository: serviceLocator()));
  serviceLocator
      .registerFactory(() => GetUser(projectRepository: serviceLocator()));

  serviceLocator.registerFactory(() => UpdateTaskProgress(
        projectRepository: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => ProjectCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => TasksCubit(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ));
}



// void _initBlog() {
//   serviceLocator
//     ..registerFactory<BlogRemoteDB>(
//         () => BlogRemoteDBImpl(supabaseClient: serviceLocator()))
//     ..registerFactory<BlogLocalDB>(() => BlogLocalDBImpl(box: serviceLocator()))
//     ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
//         blogRemoteDB: serviceLocator(),
//         blogLocalDB: serviceLocator(),
//         connectionChecker: serviceLocator()))
//     ..registerFactory(() => UploadBlog(blogRepository: serviceLocator()))
//     ..registerFactory(() => getAllBlogs(blogRepository: serviceLocator()))
//     ..registerLazySingleton(() => BlogBloc(
//         uploadBlog: serviceLocator(), get_all_blogs: serviceLocator()));
// }
