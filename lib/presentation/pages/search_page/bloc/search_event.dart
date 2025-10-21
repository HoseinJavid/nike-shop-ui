part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTextChanged extends SearchEvent {
  final String searchText;

  const SearchTextChanged(this.searchText);

  @override
  List<Object> get props => [searchText];
}

class ClearSearchHistory extends SearchEvent {}

class RemoveResultSearchItem extends SearchEvent {
  final SearchType type;
  final Product item;

  const RemoveResultSearchItem(this.item, this.type);

  @override
  List<Object> get props => [item];
}

class LoadSearchHistory extends SearchEvent {}

class SubmitSearchHistory extends SearchEvent {
  final String searchText;

  const SubmitSearchHistory(this.searchText);

  @override
  List<Object> get props => [searchText];
}

enum SearchType { recent, result }



