import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/Posts/domain/repositories/posts_repositories.dart';

import '../entities/post_entitie.dart';

class UpdatePostUseCase{
  PostRepositories repositories;
  UpdatePostUseCase({required this.repositories});

  Future<Either<Failure,Unit>> call({required Post post})async{
    return await repositories.updatePost(post: post);
  }
}