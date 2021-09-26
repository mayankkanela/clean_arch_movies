import 'package:equatable/equatable.dart';

class CurrentUser extends Equatable {
  final String userId;
  final String email;

  const CurrentUser({required this.userId, required this.email});

  @override
  List<Object?> get props => [userId, email];
}
