import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/repositories/subscription_repository.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionRepository repository;

  SubscriptionCubit(this.repository) : super(SubscriptionState(repository.hasAccess()));

  void buyResponses() {
    repository.purchaseResponses();
    emit(SubscriptionState(repository.hasAccess()));
  }

  void buyMonthly() {
    repository.purchaseMonthly();
    emit(SubscriptionState(repository.hasAccess()));
  }
}
