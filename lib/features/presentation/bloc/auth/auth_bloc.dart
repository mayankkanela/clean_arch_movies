import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/usecase/usecase.dart';
import 'package:movies/features/domain/entities/current_user.dart';
import 'package:movies/features/domain/usecases/authusecases/check_user.dart';
import 'package:movies/features/domain/usecases/authusecases/log_out.dart';
import 'package:movies/features/domain/usecases/authusecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogOut _logOut;
  final SignIn _signIn;
  final CheckUser _checkUser;
  AuthBloc(
      {required LogOut logOut,
      required SignIn signIn,
      required CheckUser checkUser})
      : _signIn = signIn,
        _logOut = logOut,
        _checkUser = checkUser,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is CheckUserEvent) {
        final dataOrFailure = await _checkUser(NoParams());
        emit(dataOrFailure.fold(
            (l) => SignedOut(), (r) => SignedIn(currentUser: r)));
      } else if (event is SignInEvent) {
        final dataOrFailure = await _signIn(NoParams());
        emit(dataOrFailure.fold(
            (l) => ErrorState(message: 'Some error occurred. Try again!'),
            (r) => SignedIn(currentUser: r)));
      } else if (event is LogOutEvent) {
        final dataOrFailure = await _logOut(NoParams());
        emit(dataOrFailure.fold(
            (l) => ErrorState(message: 'Some error occurred'),
            (r) => SignedOut()));
      }
    });
  }
}
