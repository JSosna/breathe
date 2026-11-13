import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';
import 'package:medcare_breathing/features/user/domain/repositories/user_repository.dart';

@injectable
class GetUserProfileUseCase {
  const new(this._repository);

  final UserRepository _repository;

  Future<Result<UserProfile>> call() => _repository.getProfile();
}
