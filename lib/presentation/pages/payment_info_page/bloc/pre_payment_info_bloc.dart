import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practice/core/error/m_exeption.dart';
import 'package:practice/data/model/order_submit_response.dart';
import 'package:practice/data/repository/payment_order_repository.dart';

part 'pre_payment_info_event.dart';
part 'pre_payment_info_state.dart';

class PrePaymentInfoBloc
    extends Bloc<PrePaymentInfoEvent, PrePaymentInfoState> {
  final IPaymentOrderRepository orderRepository;
  PrePaymentInfoBloc(this.orderRepository) : super(PrePaymentInitial()) {
    on<PrePaymentInfoEvent>((event, emit) async {
      try {
        if (event is StartInitPrePay) {
          emit(PaymentProcessLoading());
          var response = await orderRepository.submit(
            event.firstName,
            event.lastName,
            event.postalCode,
            event.mobile,
            event.address,
            event.paymentMethod,
          );
          emit(SucsessPrePay(response));
        }
      } catch (e) {
        if (e is ValidationException) {
          if (e.errors!['error'] == 'Cart is empty') {
            emit(PaymentProcessError('یه محصول به سبد خریدت اضافه کن خالیه'));
          }
        } else {
          emit(PaymentProcessError('خطای پرداخت دوباره تلاش کن'));
        }
      }
    });
  }
}
