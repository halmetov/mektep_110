import '../../domain/repositories/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  bool _hasAccess = false;

  @override
  bool hasAccess() => _hasAccess;

  @override
  void purchaseMonthly() {
    _hasAccess = true;
  }

  @override
  void purchaseResponses() {
    _hasAccess = true;
  }
}
