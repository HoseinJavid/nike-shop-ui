import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practice/core/utils/recent_searches.dart';
import 'package:practice/core/utils/util.dart';
import 'package:practice/data/model/product.dart';
import 'package:practice/data/repository/product_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IproductRepository repository;
  SearchBloc(this.repository) : super(SearchInitial()) {
    List<Product> fetchProducts = [];
    List<Product> resultSearchProductFiltered = [];
    List<Product> recentSearchProductFiltered = [];
    bool searchFildIsEmpty = true; //latest status

    on<SearchEvent>((event, emit) async {
      if (event is LoadSearchHistory) {
        fetchProducts = await repository.getProducts(1);
        
      }
      if (event is SearchTextChanged) {
        searchFildIsEmpty = event.searchText.isEmpty;
        emit(SearchLoading());
        await Future.delayed(const Duration(milliseconds: 300));
        resultSearchProductFiltered = filterProductsByTitle(
          fetchProducts,
          event.searchText,
        );

        recentSearchProductFiltered = await getRecentSearchHistory(
          fetchProducts,
        );
        emit(
          SearchLoaded(
            searchFildIsEmpty,
            resultsSearchs: resultSearchProductFiltered,
            recentSearches: recentSearchProductFiltered,
          ),
        );
      }
      if (event is SubmitSearchHistory) {
        await submitRecentSearchHistory(event.searchText);
      }
      if (event is RemoveResultSearchItem) {
        emit(SearchLoading());
        if (event.type == SearchType.recent) {
          recentSearchProductFiltered = await removeRecentSearchHistory(
            event.item.title,
            recentSearchProductFiltered,
          );
        } else if (event.type == SearchType.result) {
          resultSearchProductFiltered.removeWhere(
            (element) => element.id == event.item.id,
          );
        }
        emit(
          SearchLoaded(
            searchFildIsEmpty,
            resultsSearchs: resultSearchProductFiltered,
            recentSearches: recentSearchProductFiltered,
          ),
        );
      }
    });
  }
}
