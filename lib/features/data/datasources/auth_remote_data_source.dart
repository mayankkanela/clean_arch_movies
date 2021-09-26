import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/features/domain/entities/current_user.dart';

abstract class AuthRemoteDataSource {
  Future<CurrentUser> signIn();

  Future<bool> logOut();
  Future<CurrentUser> checkUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<bool> logOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<CurrentUser> signIn() async {
    try {
      return _signInWithGoogle();
    } catch (e) {
      throw ServerException();
    }
  }

  Future<CurrentUser> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential data =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return CurrentUser(userId: data.user!.uid, email: data.user!.email!);
  }

  @override
  Future<CurrentUser> checkUser() async {
    try {
      final data = _firebaseAuth.currentUser!;
      return CurrentUser(userId: data.uid, email: data.email!);
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }
}
