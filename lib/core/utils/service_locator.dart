import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ride_glide/core/utils/api_service.dart';
import 'package:ride_glide/features/Home/data/repos/Home_repo_implementation.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      apiService: getIt.get<ApiService>(),
    ),
  );
}
