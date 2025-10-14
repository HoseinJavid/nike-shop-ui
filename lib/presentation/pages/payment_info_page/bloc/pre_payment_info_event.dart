part of 'pre_payment_info_bloc.dart';

sealed class PrePaymentInfoEvent extends Equatable {
  const PrePaymentInfoEvent();

  @override
  List<Object> get props => [];
}

class StartInitPrePay extends PrePaymentInfoEvent {
  final String firstName;
  final String lastName;
  final int postalCode;
  final String mobile;
  final String address;
  final String paymentMethod;

  const StartInitPrePay(
    this.firstName,
    this.lastName,
    this.postalCode,
    this.address,
    this.paymentMethod,
    this.mobile,
  );

  @override
  List<Object> get props => [
    firstName,
    lastName,
    postalCode,
    mobile,
    address,
    paymentMethod,
  ];
}
