import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practice/data/model/product.dart';
import 'package:practice/data/repository/auth_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final IauthRepository authRepository;
  CartBloc(this.authRepository) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      if (event is LoadCart) {
        emit(CartLoading());
        if (await authRepository.isLogin() == true) {
          //get cart items from api
          // emit(CartLoaded());
          // if cart items or cart count is zero
          emit(CartEmpty());
        } else {
          emit(
            CartError(
              "برای مشاهده سبد خرید ابتدا وارد شوید",
              CartErrorType.notLoggedIn,
            ),
          );
        }
      }
    });
  }
}
