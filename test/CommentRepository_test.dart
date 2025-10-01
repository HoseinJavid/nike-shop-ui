import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice/data/datasources/banner_data_source.dart';
import 'package:practice/data/datasources/comment_data_source.dart';
import 'package:practice/data/model/banner.dart';
import 'package:practice/data/model/comment.dart';
import 'package:practice/data/repository/banner_repository.dart';
import 'package:practice/data/repository/comment_repository.dart';

void main() {
  late Dio httpClient;
  late ICommentRepository commentRepository;

  setUp(() {
    httpClient = Dio(BaseOptions(baseUrl: 'http://localhost:8085/api/v1'));
    commentRepository = CommentRepositoryImpl(
      remote: CommentRemoteDataSourceImpl(httpClient: httpClient),
    );
  });

  test('get comments', () async {
    final comments = await commentRepository.getCommnets(1);
    expect(comments, isA<List<Comment>>());
    expect(comments.isNotEmpty, true);
  });
}
