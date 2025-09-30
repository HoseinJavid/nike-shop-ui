part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();
  
  @override
  List<Object> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {}
