import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_manager/core/shared/user.dart';
import 'package:project_manager/features/auth/domain/usecases/login.dart';
import 'package:project_manager/features/auth/domain/usecases/register.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRegister _registerUser;
  final UserLogin _userLogin;
  AuthCubit(this._registerUser, this._userLogin) : super(AuthInitial());

  void login(String email, String password) async {
    final res = await _userLogin.loginUser(email, password);
    if (res != null) {
      emit(AuthSuccess(user: res));
    } else {
      emit(AuthFailue(message: "Error signing in, please try again!"));
    }
  }

  void register(String email, String password, String name) async {
    final res = await _registerUser.registerUser(email, password, name);
    if (res != null) {
      emit(AuthSuccess(user: res));
    } else {
      emit(AuthFailue(message: "Error signing up, please try again!"));
    }
  }

  void logoutUser() {
    emit(AuthInitial());
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(change);
  }
}
