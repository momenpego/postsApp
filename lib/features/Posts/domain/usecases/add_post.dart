import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/Posts/domain/entities/post_entitie.dart';
import 'package:posts_app/features/Posts/domain/repositories/posts_repositories.dart';

class AddPostUseCase {
  PostRepositories repositories;
  AddPostUseCase({required this.repositories});

  Future<Either<Failure, Unit>> call({required Post post}) async {
    return await repositories.addPost(post: post);
  }
}
