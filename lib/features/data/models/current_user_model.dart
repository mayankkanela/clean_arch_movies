import 'package:movies/features/domain/entities/current_user.dart';

class CurrentUserModel extends CurrentUser {
  static const userIdConst = 'userId';
  static const emailConst = 'email';

  const CurrentUserModel({
    required String userId,
    required String email,
  }) : super(userId: userId, email: email);

  Map<String, dynamic> toJson() => <String, dynamic>{
        userIdConst: userId,
        emailConst: email,
      };
}
