import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practice/core/constants/constant.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial(SortType.newest)) {
    on<ProductListEvent>((event, emit) {
      if (event is ChangeProductListSortTypeEvent) {
        emit(ProductListSortTypeChanged(event.sortType));
      }
    });
  }
}
