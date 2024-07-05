import 'package:project_manager/core/shared/user.dart';
import 'package:project_manager/features/auth/domain/repository/auth_repository.dart';

class UserLogin {
  final AuthRepository authRepository;

  UserLogin({required this.authRepository});
  @override
  Future<dynamic> loginUser(email, password) async {
    return await authRepository.login(email, password);
  }
}
