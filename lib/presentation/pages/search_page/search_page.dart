import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:practice/data/model/product.dart';
import 'package:practice/presentation/pages/home_page/home_page.dart';
import 'package:practice/presentation/pages/search_page/bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    BlocProvider.of<SearchBloc>(context).add(LoadSearchHistory());
    BlocProvider.of<SearchBloc>(context).add(SearchTextChanged(''));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 0, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'فروشگاه نایکی',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.pop();
                          FocusScope.of(context).unfocus();
                        },
                        icon: Icon(
                          CupertinoIcons.clear,
                          size: 24,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: McwSearchFild(
                    onTap: () {},
                    autoFocus: true,
                    onChanged: (String value) {
                      // Handle search input change
                      BlocProvider.of<SearchBloc>(
                        context,
                      ).add(SearchTextChanged(value));
                    },
                  ),
                ),
                // SizedBox(height: 4),
                SizedBox(height: 16,),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              state is SearchLoaded &&
                                          state.isSearchFildEmpty ||
                                      state is SearchInitial
                                  ? Text(
                                      'جستوی اخیر',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    )
                                  : state is SearchLoaded
                                  ? Text(
                                      'نتایج جستجو',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    )
                                  : state is SearchLoading
                                  ? SpinKitThreeBounce(
                                      color: Theme.of(context).primaryColor,
                                      size: 20,
                                    )
                                  : Container(),
                              // TextButton(
                              //   onPressed: () {},
                              //   child: Text(
                              //     'دیدن همه نتایج',
                              //     style: TextStyle(
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w600,
                              //       color: Theme.of(context).primaryColor,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        state is SearchLoaded &&
                                state.isSearchFildEmpty &&
                                state.recentSearches.isEmpty
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'تاریخچت خالیه',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Lottie.asset(
                                    'assets/animation/empty-history.json',
                                    width: 300,
                                    height: 300,
                                  ),
                                ],
                              )
                            : state is SearchLoaded && state.isSearchFildEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.recentSearches.length,
                                itemBuilder: (context, index) {
                                  return McwResultSearchItem(
                                    searchType: SearchType.recent,
                                    item: state.recentSearches[index],
                                  );
                                },
                              )
                            : state is SearchLoaded &&
                                  state.resultsSearchs.isEmpty
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'گشتم نبود نگرد نیست',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Lottie.asset(
                                    'assets/animation/Empty-Search.json',
                                    width: 300,
                                    height: 300,
                                  ),
                                ],
                              )
                            : state is SearchLoading
                            ? SizedBox(
                                height: 100,
                                child: Center(
                                  child: SpinKitThreeBounce(
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                ),
                              )
                            : state is SearchLoaded
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.resultsSearchs.length,
                                itemBuilder: (context, index) {
                                  return McwResultSearchItem(
                                    searchType: SearchType.result,
                                    item: state.resultsSearchs[index],
                                  );
                                },
                              )
                            : Container(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class McwResultSearchItem extends StatelessWidget {
  final SearchType searchType;
  final Product item;
  const McwResultSearchItem({
    super.key,
    required this.item,
    required this.searchType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        BlocProvider.of<SearchBloc>(
          context,
        ).add(SubmitSearchHistory(item.title));
        context.push('/productDetail', extra: item);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 0,
              bottom: 0,
              top: 0,
            ),
            child: Row(
              children: [
                Icon(CupertinoIcons.clock, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ),
                IconButton(
                  onPressed: () => BlocProvider.of<SearchBloc>(
                    context,
                  ).add(RemoveResultSearchItem(item, searchType)),
                  icon: Icon(
                    CupertinoIcons.clear,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade200, height: 1),
        ],
      ),
    );
  }
}
