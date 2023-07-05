import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/Network/network.dart';
import 'package:posts_app/features/Posts/data/datasources/local_data.dart';
import 'package:posts_app/features/Posts/data/datasources/remote_data.dart';
import 'package:posts_app/features/Posts/data/repositories/post_repo_imp.dart';
import 'package:posts_app/features/Posts/domain/repositories/posts_repositories.dart';
import 'package:posts_app/features/Posts/domain/usecases/add_post.dart';
import 'package:posts_app/features/Posts/domain/usecases/delete_post.dart';
import 'package:posts_app/features/Posts/domain/usecases/get_posts.dart';
import 'package:posts_app/features/Posts/domain/usecases/update_post.dart';
import 'package:posts_app/features/Posts/presentation/bloc/add_delete_update_bloc.dart';
import 'package:posts_app/features/Posts/presentation/bloc/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> injectAll() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton<NetWorkChecker>(
      () => NetWorkCheckerImp(connectionChecker: sl()));

  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImp(sharedPreferences: sl()));
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImp());

  sl.registerLazySingleton<PostRepositories>(() => PostRepositoriesImp(
      localDataSource: sl(), netWorkChecker: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton(() => GetAllPostsUseCase(repositories: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repositories: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repositories: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(repositories: sl()));

  sl.registerFactory(() => PostsBloc(getAll: sl()));
  sl.registerFactory(() =>
      AddDeleteUpdateBloc(addPost: sl(), deletePost: sl(), updatePost: sl()));
}
