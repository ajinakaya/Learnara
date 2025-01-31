import 'package:get_it/get_it.dart';
import 'package:learnara/core/network/hive_service.dart';
import 'package:learnara/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:learnara/features/auth/data/repository/auth_local_repository/auth_local_respository.dart';
import 'package:learnara/features/auth/domain/usecase/login_usecase.dart';
import 'package:learnara/features/auth/domain/usecase/register_usecase.dart';
import 'package:learnara/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:learnara/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:learnara/features/home/presentation/view_model/home_cubit.dart';
import 'package:learnara/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // initialize hive service
  await _initHiveService();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  _initSplashDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
        () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
        () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
        () => RegisterBloc(
      registerUseCase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
        () => HomeCubit(),
  );
}

_initLoginDependencies() async {

  getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
        () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

// ====================================splashscreen=============================
void _initSplashDependencies() {
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
}






