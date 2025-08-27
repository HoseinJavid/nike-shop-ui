part of 'product_list_bloc.dart';

sealed class ProductListState extends Equatable {
  final SortType sortType;
  const ProductListState(this.sortType);

  @override
  List<Object> get props => [];
}

final class ProductListInitial extends ProductListState {
  const ProductListInitial(super.sortType);

  @override
  // TODO: implement props
  List<Object> get props => [sortType];
}

final class ProductListSortTypeChanged extends ProductListState {
  const ProductListSortTypeChanged(super.sortType);

  @override
  // TODO: implement props
  List<Object> get props => [sortType];
}
