part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class SignedIn extends AuthState {
  final CurrentUser currentUser;

  SignedIn({required this.currentUser});

  @override
  List<Object?> get props => [];
}

class SignedOut extends AuthState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends AuthState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
