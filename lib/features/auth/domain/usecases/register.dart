import 'package:project_manager/core/shared/user.dart';
import 'package:project_manager/features/auth/domain/repository/auth_repository.dart';

class UserRegister {
  final AuthRepository authRepository;

  UserRegister({required this.authRepository});
  @override
  Future<dynamic> registerUser(email, password, name) async {
    return await authRepository.register(email, password, name);
  }
}
