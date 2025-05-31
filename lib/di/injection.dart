import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zoodex_walk/features/bottomNavigationBar/presentation/providers/navigation_provider.dart';
import 'package:zoodex_walk/features/homePage/data/datasources/banner_remote_data_source.dart';
import 'package:zoodex_walk/features/homePage/data/repositories_impl/banner_repository_impl.dart';
import 'package:zoodex_walk/features/homePage/domain/repositories/banner_repository.dart';
import 'package:zoodex_walk/features/homePage/domain/usecases/get_banners_usecase.dart';
import 'package:zoodex_walk/features/homePage/presentation/providers/banner_provider.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // HTTP Client (Dio)
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://admin.zoodex.ir/api/walk/v1',
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    ),
  );
  // Banner Remote Data Source
  getIt.registerLazySingleton<BannerRemoteDataSource>(
    () => BannerRemoteDataSourceImpl(getIt<Dio>()),
  );

  // Banner Repository
  getIt.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(getIt<BannerRemoteDataSource>()),
  );

  // GetBanners UseCase
  getIt.registerLazySingleton<GetBannersUseCase>(
    () => GetBannersUseCase(getIt<BannerRepository>()),
  );

  // BannerProvider (ChangeNotifier)
  getIt.registerFactory<BannerProvider>(
    () => BannerProvider(getIt<GetBannersUseCase>()),
  );

  // NavigationProvider
  getIt.registerFactory<NavigationProvider>(() => NavigationProvider());
}
