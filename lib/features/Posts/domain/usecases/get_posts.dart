import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/Posts/domain/entities/post_entitie.dart';
import 'package:posts_app/features/Posts/domain/repositories/posts_repositories.dart';

class GetAllPostsUseCase {
  PostRepositories repositories;

  GetAllPostsUseCase({required this.repositories});

  Future<Either<Failure, List<Post>>> call() async {
    return await repositories.getAllPosts();
  }
}
