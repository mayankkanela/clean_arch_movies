import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/core/usecase/usecase.dart';
import 'package:movies/features/domain/entities/current_user.dart';
import 'package:movies/features/domain/repositories/auth_repository.dart';

class SignIn extends UseCase<CurrentUser, NoParams> {
  final AuthRepository _authRepository;

  SignIn({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, CurrentUser>> call(NoParams params) async =>
      await _authRepository.signIn();
}
