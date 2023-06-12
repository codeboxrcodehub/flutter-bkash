part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {
  const PaymentState();
}

class PaymentInitialState extends PaymentState {
  const PaymentInitialState();
}

class PaymentProcessingState extends PaymentState {
  const PaymentProcessingState();
}

class PaymentProcessedState extends PaymentState {
  final BkashPaymentStatus bkashPaymentStatus;

  const PaymentProcessedState({
    required this.bkashPaymentStatus,
  });
}
