part of 'subscription_cubit.dart';

class SubscriptionState extends Equatable {
  final bool hasAccess;

  const SubscriptionState(this.hasAccess);

  @override
  List<Object?> get props => [hasAccess];
}
