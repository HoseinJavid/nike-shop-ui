part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final bool isSearchFildEmpty;
  final List<Product> resultsSearchs;
  final List<Product> recentSearches;

  const SearchLoaded(
    this.isSearchFildEmpty, {
    required this.resultsSearchs,
    required this.recentSearches,
  });

  @override
  List<Object> get props => [resultsSearchs, recentSearches];
}
