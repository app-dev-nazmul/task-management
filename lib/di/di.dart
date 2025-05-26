import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:technical_task/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: false,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();
