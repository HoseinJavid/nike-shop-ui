part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {}

final class LoadedCommets extends ProductDetailState {
  final List<Comment> commets;

  const LoadedCommets({required this.commets});

  @override
  List<Object> get props => [commets];
}

final class ErrorLoadCommets extends ProductDetailState implements AppError {
  final String message;

  const ErrorLoadCommets({required this.message});

  @override
  List<Object> get props => [message];
}

final class LoadingCommets extends ProductDetailState {}
