enum LayoutType { grid, verticallList, horizontalList }

enum SortType { newest, bestSelling, cheapest, mostExpensive,popular }

typedef OnTapCallback = void Function();

typedef McValueChanged<S, P> = P Function(S value);