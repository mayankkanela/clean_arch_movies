part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent  {}

class SignInEvent extends AuthEvent {
  }

class CheckUserEvent extends AuthEvent {
 }

class LogOutEvent extends AuthEvent {
 }
