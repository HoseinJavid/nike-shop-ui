part of 'pre_payment_info_bloc.dart';

sealed class PrePaymentInfoState extends Equatable {
  const PrePaymentInfoState();

  @override
  List<Object> get props => [];
}

final class PrePaymentInitial extends PrePaymentInfoState {}

final class SucsessPrePay extends PrePaymentInfoState {
  final OrderSubmitResponse response;
  const SucsessPrePay(this.response);
  @override
  List<Object> get props => [response];
}

final class PaymentProcessError extends PrePaymentInfoState {
  final String message;
  const PaymentProcessError(this.message);
  @override
  List<Object> get props => [message];
}

final class PaymentProcessLoading extends PrePaymentInfoState {}
