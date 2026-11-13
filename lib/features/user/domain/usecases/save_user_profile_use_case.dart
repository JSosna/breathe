import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';
import 'package:medcare_breathing/features/user/domain/repositories/user_repository.dart';

@injectable
class SaveUserProfileUseCase {
  const new(this._repository);

  final UserRepository _repository;

  Future<Result<void>> call(UserProfile profile) =>
      _repository.saveProfile(profile);
}
