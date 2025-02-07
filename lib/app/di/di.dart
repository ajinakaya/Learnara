import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:learnara/app/share_pref/token_share_pref.dart';
import 'package:learnara/core/network/api_service.dart';
import 'package:learnara/core/network/hive_service.dart';
import 'package:learnara/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:learnara/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:learnara/features/auth/data/repository/auth_local_repository/auth_local_respository.dart';
import 'package:learnara/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:learnara/features/auth/domain/usecase/login_usecase.dart';
import 'package:learnara/features/auth/domain/usecase/register_usecase.dart';
import 'package:learnara/features/auth/domain/usecase/upload_image_usecase.dart';
import 'package:learnara/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:learnara/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:learnara/features/home/presentation/view_model/home_cubit.dart';
import 'package:learnara/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {

  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  _initSplashDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // remote data source
  getIt.registerLazySingleton<Dio>(
        () => ApiService(Dio()).dio,
  );
}

//======================================== Register ===========================================================================
_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
        () => AuthLocalDataSource(getIt<HiveService>()),
  );
  getIt.registerLazySingleton<AuthRemoteDatasource>(
          () => AuthRemoteDatasource(getIt<Dio>()));

// ==========================================Repository=========================================================================

  // init local repository
  getIt.registerLazySingleton(
        () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton(
        () => AuthRemoteRepository(
      getIt<AuthRemoteDatasource>(),
    ),
  );
 // ========================================= use case =============================================================================

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<UploadImageUsecase>(
        () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
        () => RegisterBloc(
      registerUseCase: getIt(),
          uploadImageUsecase: getIt(),
    ),
  );
}

//================================================home page =================================================================

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
        () => HomeCubit(),
  );
}

//================================================login ==============================================================================

_initLoginDependencies() async {

  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
        () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(
          getIt<AuthRemoteRepository>(),
          getIt<TokenSharedPrefs>(),
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






