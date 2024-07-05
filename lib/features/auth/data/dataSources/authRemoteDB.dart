import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_manager/features/auth/data/models/userModel.dart';

abstract interface class AuthRemoteDB {
  // Session? get currentUserSession;
  Future<dynamic> SignUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<dynamic> SignInWithEmail({
    required String email,
    required String password,
  });
  Future<dynamic> getCurrentUserData();
  void logout();
}

class AuthRemoteDBImpl implements AuthRemoteDB {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<dynamic> SignInWithEmail(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? firebaseUser = credential.user;

      if (firebaseUser != null) {
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          name: firebaseUser.displayName ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<dynamic> SignUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        _firebaseAuth.currentUser!.updateDisplayName(name);

        firestore.collection('users').doc().set({
          'name': name,
          'email': firebaseUser.email ?? '',
          'id': firebaseUser.uid,
          'createdAt': DateTime.now(),
        });
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          name: firebaseUser.displayName ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Future<dynamic> getCurrentUserData() {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return Future.value(UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
      ));
    }
    return Future.value(null);
  }

  @override
  void logout() {
    _firebaseAuth.signOut();
  }
}
