part of 'product_list_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ChangeProductListSortTypeEvent extends ProductListEvent {
  final SortType sortType;

  const ChangeProductListSortTypeEvent({required this.sortType});

  @override
  List<Object> get props => [sortType];
}