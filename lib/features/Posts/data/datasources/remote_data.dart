import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:posts_app/core/Http_req/dio_req.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/Posts/data/models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> updatePost({required PostModel postModel});
  Future<Unit> addPost({required PostModel postModel});
  Future<Unit> deletePost({required int postId});
}

class RemoteDataSourceImp implements RemoteDataSource {
  @override
  Future<List<PostModel>> getAllPosts() async {
    final Response response = await Diorequest.getdata(
        url: 'posts', headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final List posts = response.data;
      final List<PostModel> allPosts =
          posts.map<PostModel>((e) => PostModel.fromjson(e)).toList();
      return allPosts;
    } else {
      throw EmptyCasheFailure();
    }
  }

  @override
  Future<Unit> addPost({required PostModel postModel}) async {
    final Map<String, dynamic> body = {
      'id': postModel.id,
      'title': postModel.title,
      'body': postModel.body
    };
    final Response response =
        await Diorequest.postdata(url: 'posts', pram: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost({required int postId}) async {
    final Response response = await Diorequest.deletdata(
        url: 'posts/$postId', headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost({required PostModel postModel}) async {
    final Map<String, dynamic> body = {
      'id': postModel.id,
      'title': postModel.title,
      'body': postModel.body
    };
    final Response response =
        await Diorequest.patchdata(url: 'posts/${postModel.id}', pram: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
