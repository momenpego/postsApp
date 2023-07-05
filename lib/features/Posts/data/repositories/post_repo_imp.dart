import 'package:posts_app/core/Network/network.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/features/Posts/data/datasources/local_data.dart';
import 'package:posts_app/features/Posts/data/datasources/remote_data.dart';
import 'package:posts_app/features/Posts/data/models/post_model.dart';
import 'package:posts_app/features/Posts/domain/entities/post_entitie.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/features/Posts/domain/repositories/posts_repositories.dart';

class PostRepositoriesImp implements PostRepositories {
  LocalDataSource localDataSource;
  RemoteDataSource remoteDataSource;
  NetWorkChecker netWorkChecker;
  PostRepositoriesImp(
      {required this.localDataSource,
      required this.netWorkChecker,
      required this.remoteDataSource});
  @override
  Future<Either<Failure, Unit>> addPost({required Post post}) async {
    final post1 = PostModel(id: post.id, title: post.title, body: post.body);
    if (await netWorkChecker.hasconnected) {
      try {
        await remoteDataSource.addPost(postModel: post1);
        return const Right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(NetWorkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost({required int postId}) async {
    if (await netWorkChecker.hasconnected) {
      try {
        await remoteDataSource.deletePost(postId: postId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetWorkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await netWorkChecker.hasconnected) {
      try {
        final List<PostModel> allPosts = await remoteDataSource.getAllPosts();
        await localDataSource.cachePosts(posts: allPosts);
        return Right(allPosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localdata = localDataSource.getAllPosts();
        return Right(localdata);
      } on EmptyCasheException {
        return Left(EmptyCasheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required Post post}) async {
    final post1 = PostModel(id: post.id, title: post.title, body: post.body);
    if (await netWorkChecker.hasconnected) {
      try {
        await remoteDataSource.updatePost(postModel: post1);
        return const Right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(NetWorkFailure());
    }
  }
}
