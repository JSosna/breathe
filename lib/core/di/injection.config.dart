// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:medcare_breathing/app/router/app_router.dart' as _i23;
import 'package:medcare_breathing/app/router/onboarding_guard.dart' as _i549;
import 'package:medcare_breathing/core/clock.dart' as _i767;
import 'package:medcare_breathing/core/di/register_module.dart' as _i639;
import 'package:medcare_breathing/features/breathing/presentation/bloc/breathing_setup_bloc.dart'
    as _i417;
import 'package:medcare_breathing/features/onboarding/data/datasources/onboarding_local_data_source.dart'
    as _i1067;
import 'package:medcare_breathing/features/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i529;
import 'package:medcare_breathing/features/onboarding/domain/repositories/onboarding_repository.dart'
    as _i875;
import 'package:medcare_breathing/features/onboarding/domain/usecases/complete_onboarding_use_case.dart'
    as _i426;
import 'package:medcare_breathing/features/onboarding/domain/usecases/is_onboarding_completed_use_case.dart'
    as _i559;
import 'package:medcare_breathing/features/onboarding/presentation/cubit/onboarding_cubit.dart'
    as _i588;
import 'package:medcare_breathing/features/summary/domain/usecases/build_session_summary_use_case.dart'
    as _i833;
import 'package:medcare_breathing/features/summary/presentation/cubit/summary_cubit.dart'
    as _i468;
import 'package:medcare_breathing/features/user/data/datasources/user_remote_data_source.dart'
    as _i94;
import 'package:medcare_breathing/features/user/data/mappers/user_mapper.dart'
    as _i41;
import 'package:medcare_breathing/features/user/data/repositories/user_repository_impl.dart'
    as _i19;
import 'package:medcare_breathing/features/user/domain/repositories/user_repository.dart'
    as _i746;
import 'package:medcare_breathing/features/user/domain/usecases/get_user_profile_use_case.dart'
    as _i1046;
import 'package:medcare_breathing/features/user/domain/usecases/save_user_profile_use_case.dart'
    as _i447;
import 'package:medcare_breathing/shared/rive/rive_file_cache.dart' as _i203;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i417.BreathingSetupBloc>(() => _i417.BreathingSetupBloc());
    gh.factory<_i41.UserMapper>(() => const _i41.UserMapper());
    gh.lazySingleton<_i203.RiveFileCache>(() => _i203.RiveFileCache());
    gh.lazySingleton<_i94.UserRemoteDataSource>(
      () => _i94.MockUserRemoteDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i767.Clock>(() => const _i767.SystemClock());
    gh.lazySingleton<_i1067.OnboardingLocalDataSource>(
      () => _i1067.OnboardingLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i875.OnboardingRepository>(
      () => _i529.OnboardingRepositoryImpl(
        gh<_i1067.OnboardingLocalDataSource>(),
      ),
    );
    gh.factory<_i426.CompleteOnboardingUseCase>(
      () => _i426.CompleteOnboardingUseCase(gh<_i875.OnboardingRepository>()),
    );
    gh.factory<_i559.IsOnboardingCompletedUseCase>(
      () =>
          _i559.IsOnboardingCompletedUseCase(gh<_i875.OnboardingRepository>()),
    );
    gh.lazySingleton<_i746.UserRepository>(
      () => _i19.UserRepositoryImpl(
        gh<_i94.UserRemoteDataSource>(),
        gh<_i41.UserMapper>(),
      ),
    );
    gh.factory<_i1046.GetUserProfileUseCase>(
      () => _i1046.GetUserProfileUseCase(gh<_i746.UserRepository>()),
    );
    gh.factory<_i447.SaveUserProfileUseCase>(
      () => _i447.SaveUserProfileUseCase(gh<_i746.UserRepository>()),
    );
    gh.factory<_i588.OnboardingCubit>(
      () => _i588.OnboardingCubit(
        gh<_i447.SaveUserProfileUseCase>(),
        gh<_i426.CompleteOnboardingUseCase>(),
        gh<_i767.Clock>(),
      ),
    );
    gh.factory<_i833.BuildSessionSummaryUseCase>(
      () => _i833.BuildSessionSummaryUseCase(gh<_i767.Clock>()),
    );
    gh.lazySingleton<_i549.OnboardingGuard>(
      () => _i549.OnboardingGuard(gh<_i559.IsOnboardingCompletedUseCase>()),
    );
    gh.factory<_i468.SummaryCubit>(
      () => _i468.SummaryCubit(
        gh<_i1046.GetUserProfileUseCase>(),
        gh<_i833.BuildSessionSummaryUseCase>(),
      ),
    );
    gh.lazySingleton<_i23.AppRouter>(
      () => _i23.AppRouter(gh<_i549.OnboardingGuard>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i639.RegisterModule {}
