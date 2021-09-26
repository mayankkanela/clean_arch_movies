import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/core/usecase/usecase.dart';
import 'package:movies/features/domain/repositories/auth_repository.dart';

class LogOut extends UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  LogOut({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async =>
      await _authRepository.logOut();
}
