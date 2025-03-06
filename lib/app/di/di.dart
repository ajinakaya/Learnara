import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:learnara/app/share_pref/token_share_pref.dart';
import 'package:learnara/core/network/api_service.dart';
import 'package:learnara/core/network/hive_service.dart';
import 'package:learnara/features/Activitytype/data/data_source/activity_data_source.dart';
import 'package:learnara/features/Activitytype/data/data_source/remote_datasource/activity_remote_datasource.dart';
import 'package:learnara/features/Activitytype/data/repository/remote_repository/activity_remote_repository.dart';
import 'package:learnara/features/Activitytype/domain/repository/activity_repository.dart';
import 'package:learnara/features/Activitytype/domain/usecase/activity_usecase.dart';
import 'package:learnara/features/Activitytype/presentation/view_model/activity/activity_bloc.dart';
import 'package:learnara/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:learnara/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:learnara/features/auth/data/repository/auth_local_repository/auth_local_respository.dart';
import 'package:learnara/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:learnara/features/auth/domain/repository/auth_repository.dart';
import 'package:learnara/features/auth/domain/usecase/login_usecase.dart';
import 'package:learnara/features/auth/domain/usecase/register_usecase.dart';
import 'package:learnara/features/auth/domain/usecase/upload_image_usecase.dart';
import 'package:learnara/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:learnara/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:learnara/features/courses/data/data_source/course_data_source.dart';
import 'package:learnara/features/courses/data/data_source/local_data_source/course_local_datasource.dart';
import 'package:learnara/features/courses/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:learnara/features/courses/data/repository/course_local_repository/course_local_repository.dart';
import 'package:learnara/features/courses/data/repository/remote_repository/course_remote_repository.dart';
import 'package:learnara/features/courses/domain/repository/course_repository.dart';
import 'package:learnara/features/courses/domain/usecase/getallchapter.dart';
import 'package:learnara/features/courses/domain/usecase/getallcourse.dart';
import 'package:learnara/features/courses/domain/usecase/getallsublesson.dart';
import 'package:learnara/features/courses/domain/usecase/getchapterbyid.dart';
import 'package:learnara/features/courses/domain/usecase/getcoursebyid.dart';
import 'package:learnara/features/courses/domain/usecase/getsublessonbyid.dart';
import 'package:learnara/features/courses/presentation/view_model/course_bloc.dart';
import 'package:learnara/features/home/presentation/view_model/home_cubit.dart';
import 'package:learnara/features/langauge/data/data_source/local_data_source/language_local_datasource.dart';
import 'package:learnara/features/langauge/data/data_source/remote_datasource/language_remote_datasource.dart';
import 'package:learnara/features/langauge/data/repository/language_local_repository/langauge_local_repository.dart';
import 'package:learnara/features/langauge/data/repository/remote_repository/language_remote_repository.dart';
import 'package:learnara/features/langauge/domain/repository/language_repository.dart';
import 'package:learnara/features/langauge/domain/usecase/get_all_languages_usecase.dart';
import 'package:learnara/features/langauge/domain/usecase/get_user_preferred_language_usecase.dart';
import 'package:learnara/features/langauge/domain/usecase/set_user_preferred_language_usecase.dart';
import 'package:learnara/features/langauge/presentation/view_model/language/language_bloc.dart';
import 'package:learnara/features/profile/domain/use_case/get_current_user_usecase.dart';
import 'package:learnara/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:learnara/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initAuthDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initLanguageDependencies();
  await _initProfileDependencies();
  await _initActivityDependencies();
  await _initCourseDependencies();
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
  // Register ApiService
  getIt.registerLazySingleton<ApiService>(
        () => ApiService(Dio()),
  );

  // Register Dio (if you still need it separately)
  getIt.registerLazySingleton<Dio>(
        () => getIt<ApiService>().dio,
  );
}

//======================================== Auth Base Dependencies ===========================================================================
Future<void> _initAuthDependencies() async {
  // init local data source
  getIt.registerLazySingleton(
        () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDatasource>(
          () => AuthRemoteDatasource(getIt<Dio>()));

  // init local repository
  getIt.registerLazySingleton(
        () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton(
        () => AuthRemoteRepository(
      getIt<AuthRemoteDatasource>(),
    ),
  );

  // Register the interface implementation
  getIt.registerLazySingleton<IAuthRepository>(
        () => AuthRemoteRepository(
      getIt<AuthRemoteDatasource>(),
    ),
  );
}

//======================================== Register ===========================================================================
_initRegisterDependencies() {
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
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
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

//======================================language=============================================

Future<void> _initLanguageDependencies() async {
  // Data sources
  getIt.registerLazySingleton<LanguageLocalDataSource>(
        () => LanguageLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<LanguageRemoteDataSource>(
        () => LanguageRemoteDataSource(dio: getIt<Dio>()),
  );

  // Repositories
  getIt.registerLazySingleton<LanguageLocalRepository>(
        () => LanguageLocalRepository(getIt<LanguageLocalDataSource>()),
  );

  getIt.registerLazySingleton<LanguageRemoteRepository>(
        () => LanguageRemoteRepository(getIt<LanguageRemoteDataSource>()),
  );

  // Register the interface implementation
  getIt.registerLazySingleton<ILanguageRepository>(
        () => LanguageRemoteRepository(getIt<LanguageRemoteDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton<GetAllLanguagesUseCase>(
        () => GetAllLanguagesUseCase(getIt<ILanguageRepository>()),
  );

  getIt.registerLazySingleton<SetUserPreferredLanguageUseCase>(
        () => SetUserPreferredLanguageUseCase(getIt<ILanguageRepository>()),
  );

  getIt.registerLazySingleton<GetUserPreferredLanguageUseCase>(
        () => GetUserPreferredLanguageUseCase(getIt<ILanguageRepository>()),
  );

  // BLoC
  getIt.registerFactory<LanguageBloc>(
        () => LanguageBloc(
      getAllLanguagesUseCase: getIt<GetAllLanguagesUseCase>(),
      setUserPreferredLanguageUseCase: getIt<SetUserPreferredLanguageUseCase>(),
      getUserPreferredLanguageUseCase: getIt<GetUserPreferredLanguageUseCase>(),
      apiService: getIt<ApiService>(),
    ),
  );
}

//======================================profile=============================================

Future<void> _initProfileDependencies() async {
  // Use case
  getIt.registerLazySingleton<GetCurrentUserUseCase>(
        () => GetCurrentUserUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // BLoC - using registerFactory to ensure a new instance is created each time
  getIt.registerFactory<ProfileBloc>(
        () => ProfileBloc(
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
    ),
  );
}

//======================================== Activity Dependencies ===========================================================================
Future<void> _initActivityDependencies() async {
  // Data Source
  getIt.registerLazySingleton<IActivityDataSource>(
        () => ActivityRemoteDataSource(getIt<Dio>()),
  );

  // Repository
  getIt.registerLazySingleton<IActivityRepository>(
        () => ActivityRemoteRepository(getIt<IActivityDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetAllFlashcardsUseCase>(
        () => GetAllFlashcardsUseCase(getIt<IActivityRepository>()),
  );

  getIt.registerLazySingleton<GetAllQuizzesUseCase>(
        () => GetAllQuizzesUseCase(getIt<IActivityRepository>()),
  );

  getIt.registerLazySingleton<GetAllAudioActivitiesUseCase>(
        () => GetAllAudioActivitiesUseCase(getIt<IActivityRepository>()),
  );

  // BLoC
  getIt.registerFactory<ActivityBloc>(
        () => ActivityBloc(
      getAllFlashcardsUseCase: getIt<GetAllFlashcardsUseCase>(),
      getAllQuizzesUseCase: getIt<GetAllQuizzesUseCase>(),
      getAllAudioActivitiesUseCase: getIt<GetAllAudioActivitiesUseCase>(),
    ),
  );
}

Future<void> _initCourseDependencies() async {
  // Data Sources
  getIt.registerLazySingleton<ICourseDataSource>(
        () => CourseRemoteDataSource(getIt<Dio>()),
  );
  // getIt.registerLazySingleton<ICourseDataSource>(
  //       () => CourseLocalDataSource(getIt<HiveService>()),
  //
  // );

  // Repositories
  getIt.registerLazySingleton<ICourseRepository>(
        () => CourseRemoteRepository(getIt<ICourseDataSource>()),
  );

  // getIt.registerLazySingleton<ICourseRepository>(
  //       () => CourseLocalRepository(getIt<ICourseDataSource>()),
  //
  // );

  // Use Cases
  getIt.registerLazySingleton<GetAllCoursesUseCase>(
        () => GetAllCoursesUseCase(getIt<ICourseRepository>()),
  );

  getIt.registerLazySingleton<GetCourseByIdUseCase>(
        () => GetCourseByIdUseCase(getIt<ICourseRepository>()),
  );

  getIt.registerLazySingleton<GetAllChaptersUseCase>(
        () => GetAllChaptersUseCase(getIt<ICourseRepository>()),
  );

  getIt.registerLazySingleton<GetChapterByIdUseCase>(
        () => GetChapterByIdUseCase(getIt<ICourseRepository>()),
  );

  getIt.registerLazySingleton<GetAllSubLessonsUseCase>(
        () => GetAllSubLessonsUseCase(getIt<ICourseRepository>()),
  );

  getIt.registerLazySingleton<GetSubLessonByIdUseCase>(
        () => GetSubLessonByIdUseCase(getIt<ICourseRepository>()),
  );

  // BLoC
  getIt.registerFactory<CourseBloc>(
        () => CourseBloc(
      getAllCoursesUseCase: getIt<GetAllCoursesUseCase>(),
      getCourseByIdUseCase: getIt<GetCourseByIdUseCase>(),
      getAllChaptersUseCase: getIt<GetAllChaptersUseCase>(),
      getChapterByIdUseCase: getIt<GetChapterByIdUseCase>(),
      getAllSubLessonsUseCase: getIt<GetAllSubLessonsUseCase>(),
      getSubLessonByIdUseCase: getIt<GetSubLessonByIdUseCase>(),
    ),
  );
}