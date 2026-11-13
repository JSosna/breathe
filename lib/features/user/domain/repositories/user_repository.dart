import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';

abstract interface class UserRepository {
  Future<Result<UserProfile>> getProfile();

  Future<Result<void>> saveProfile(UserProfile profile);
}
