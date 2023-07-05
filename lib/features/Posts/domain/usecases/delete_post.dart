import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/Posts/domain/repositories/posts_repositories.dart';

class DeletePostUseCase {
  PostRepositories repositories;
  DeletePostUseCase({required this.repositories});

  Future<Either<Failure, Unit>> call({required int postId}) async {
    return await repositories.deletePost(postId: postId);
  }
}
