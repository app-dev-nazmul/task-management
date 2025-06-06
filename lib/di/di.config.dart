// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:technical_task/data/database/dao/task_dao.dart' as _i692;
import 'package:technical_task/data/database/local_database.dart' as _i350;
import 'package:technical_task/data/repository_impl/task_repository_impl.dart'
    as _i705;
import 'package:technical_task/di/register_module.dart' as _i730;
import 'package:technical_task/domain/repositories/task_repository.dart'
    as _i736;
import 'package:technical_task/domain/use_case/task_usecase.dart' as _i876;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i350.LocalDatabase>(
      () => registerModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i876.ValidateTaskUseCase>(
        () => _i876.ValidateTaskUseCase());
    gh.factory<_i692.TaskDao>(
        () => registerModule.taskDao(gh<_i350.LocalDatabase>()));
    gh.lazySingleton<_i876.TaskValidationResult>(
        () => _i876.TaskValidationResult(
              gh<bool>(),
              gh<String>(),
            ));
    gh.lazySingleton<_i736.TaskRepository>(
        () => _i705.TaskRepositoryImpl(gh<_i692.TaskDao>()));
    gh.lazySingleton<_i876.CreateTaskUseCase>(
        () => _i876.CreateTaskUseCase(gh<_i736.TaskRepository>()));
    gh.lazySingleton<_i876.UpdateTaskUseCase>(
        () => _i876.UpdateTaskUseCase(gh<_i736.TaskRepository>()));
    gh.lazySingleton<_i876.DeleteTaskUseCase>(
        () => _i876.DeleteTaskUseCase(gh<_i736.TaskRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i730.RegisterModule {}
