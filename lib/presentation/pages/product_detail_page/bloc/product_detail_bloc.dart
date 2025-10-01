import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practice/core/error/m_exeption.dart';
import 'package:practice/data/model/comment.dart';
import 'package:practice/data/repository/comment_repository.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ICommentRepository commentRepository;
  ProductDetailBloc(this.commentRepository) : super(ProductDetailInitial()) {
    on<ProductDetailEvent>((event, emit) async {
      emit(LoadingCommets());
      if (event is LoadCommets) {
        try {
          final comments = await commentRepository.getCommnets(event.productId);
          emit(LoadedCommets(commets: comments));
        } catch (e) {
          emit(ErrorLoadCommets(message: 'خطا در بارگذاری نظرات'));
        }
      }
    });
  }
}
