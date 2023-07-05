import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/Posts/domain/entities/post_entitie.dart';

abstract class PostRepositories {
  Future<Either<Failure, List<Post>>> getAllPosts();

  Future<Either<Failure, Unit>> addPost({required Post post});

  Future<Either<Failure, Unit>> updatePost({required Post post});

  Future<Either<Failure, Unit>> deletePost({required int postId});
}
