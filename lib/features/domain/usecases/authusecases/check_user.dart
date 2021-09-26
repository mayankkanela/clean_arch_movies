import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/core/usecase/usecase.dart';
import 'package:movies/features/domain/entities/current_user.dart';
import 'package:movies/features/domain/repositories/auth_repository.dart';

class CheckUser extends UseCase<CurrentUser, NoParams> {
  final AuthRepository _authRepository;

  CheckUser({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, CurrentUser>> call(NoParams params) async =>
      await _authRepository.checkUser();
}
