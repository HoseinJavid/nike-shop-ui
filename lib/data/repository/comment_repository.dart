import 'package:practice/data/datasources/comment_data_source.dart';
import 'package:practice/data/model/comment.dart';

abstract class ICommentRepository {
  Future<List<Comment>> getCommnets(int productId);
  Future<void> addComment(Comment comment);
}

class CommentRepositoryImpl implements ICommentRepository {
  final CommentRemoteDataSourceImpl remote;

  CommentRepositoryImpl({required this.remote});

  @override
  Future<void> addComment(Comment comment) {
    return remote.addComment(comment);
  }

  @override
  Future<List<Comment>> getCommnets(int productId) {
    return remote.getCommnets(productId);
  }

}