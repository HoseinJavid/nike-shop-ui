part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadCommets extends ProductDetailEvent {
  final int productId;

  const LoadCommets({required this.productId});

  @override
  List<Object> get props => [productId];
}
