import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bkash_payment_status.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentInitialState());

  Future<void> pay() async {
    emit(const PaymentProcessingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(PaymentProcessedState(bkashPaymentStatus: BkashPaymentStatus()));
  }
}
