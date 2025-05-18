// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hifzpro/core/service/api_service.dart' as _i561;
import 'package:hifzpro/core/service/api_service_impl.dart' as _i433;
import 'package:hifzpro/core/service/shared_prefs_service.dart' as _i750;
import 'package:hifzpro/data/repository_impl/user_repository_impl.dart'
    as _i323;
import 'package:hifzpro/di/register_module.dart' as _i887;
import 'package:hifzpro/domain/repositories/user_repository.dart' as _i938;
import 'package:injectable/injectable.dart' as _i526;
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
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i561.ApiService>(
      () => _i433.ApiServiceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i750.SharedPrefsService>(
      () => _i750.SharedPrefsServiceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i938.UserRepository>(
      () => _i323.UserRepositoryImpl(gh<_i750.SharedPrefsService>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i887.RegisterModule {}
