import 'package:dio/dio.dart';
import 'package:practice/core/network/validation.dart';
import 'package:practice/data/model/comment.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getCommnets(int productId);
  Future<void> addComment(Comment comment);
}

class CommentRemoteDataSourceImpl
    with HttpResponseValidation
    implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSourceImpl({required this.httpClient});
  @override
  Future<void> addComment(Comment comment) async {
    var response = await httpClient.post(
      '/comment/add',
      data: comment.toJson(),
    );
    validateResposnse(response);
    throw UnimplementedError();
  }

  @override
  Future<List<Comment>> getCommnets(int productId) async {
    var response = await httpClient.get('/comment/list?product_id=$productId');
    validateResposnse(response);
    List<Comment> tmp = [];
    for (var comment in response.data) {
      tmp.add(Comment.fromJson(comment));
    }
    return tmp;
  }
}
