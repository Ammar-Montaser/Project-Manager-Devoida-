import 'package:project_manager/core/shared/user.dart';
import 'package:project_manager/features/auth/data/dataSources/authRemoteDB.dart';
import 'package:project_manager/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDB authRemoteDB;
  const AuthRepositoryImpl({
    required this.authRemoteDB,
  });

  @override
  Future login(String email, String password) {
    return authRemoteDB.SignInWithEmail(email: email, password: password);
  }

  @override
  Future register(String email, String password, String name) {
    return authRemoteDB.SignUpWithEmail(
        name: name, email: email, password: password);
  }

  // Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
  //   try {
  //     if (await connectionChecker.isConnected) {
  //       final user = await fn();
  //       return right(user);
  //     } else {
  //       return left(Failure("No internet connection!"));
  //     }
  //   } on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }

//   @override
//   Future<Either<Failure, User>> currentUser() async {
//     try {
//       if (!await connectionChecker.isConnected) {
//         final session = authRemoteDB.currentUserSession;
//         if (session == null) {
//           return left(Failure("User not logged in"));
//         }
//         return right(UserModel(
//             id: session.user.id, name: "", email: session.user.email ?? ""));
//       }

//       final res = await authRemoteDB.getCurrentUserData();
//       if (res != null) {
//         return right(res);
//       } else {
//         return left(Failure("User not logged in"));
//       }
//     } on ServerException catch (e) {
//       return left(Failure(e.message));
//     }
//   }

  @override
  Future<void> logout() async {
    try {
      authRemoteDB.logout();
    } catch (e) {
      print(e.toString());
    }
  }
}
