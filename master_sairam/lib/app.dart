import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/theme.dart';
import 'data/api/mock_api_service.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/chat_repository_impl.dart';
import 'data/repositories/order_repository_impl.dart';
import 'data/repositories/specialist_repository_impl.dart';
import 'data/repositories/subscription_repository_impl.dart';
import 'domain/usecases/create_order.dart';
import 'domain/usecases/get_messages.dart';
import 'domain/usecases/get_order_detail.dart';
import 'domain/usecases/get_orders.dart';
import 'domain/usecases/get_specialists.dart';
import 'domain/usecases/login.dart';
import 'domain/usecases/send_message.dart';
import 'presentation/auth/auth_page.dart';
import 'presentation/auth/cubit/auth_cubit.dart';
import 'presentation/chat/chat_page.dart';
import 'presentation/chat/cubit/chat_cubit.dart';
import 'presentation/create_order/cubit/create_order_cubit.dart';
import 'presentation/create_order/create_order_page.dart';
import 'presentation/home/customer_home_page.dart';
import 'presentation/home/executor_home_page.dart';
import 'presentation/orders/cubit/orders_cubit.dart';
import 'presentation/orders/order_detail_page.dart';
import 'presentation/profile/profile_page.dart';
import 'presentation/roles/role_selection_page.dart';
import 'presentation/specialists/cubit/specialists_cubit.dart';
import 'presentation/specialists/specialists_page.dart';
import 'presentation/subscriptions/cubit/subscription_cubit.dart';

class MasterApp extends StatelessWidget {
  MasterApp({super.key});

  final _apiService = MockApiService();
  late final _orderRepository = OrderRepositoryImpl(_apiService);
  late final _authRepository = AuthRepositoryImpl(_apiService);
  final _chatRepository = ChatRepositoryImpl();
  late final _specialistRepository = SpecialistRepositoryImpl(_apiService);
  final _subscriptionRepository = SubscriptionRepositoryImpl();

  late final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const RoleSelectionPage(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: '/register-executor',
        builder: (context, state) => const ExecutorRegisterPage(),
      ),
      GoRoute(
        path: '/register-customer',
        builder: (context, state) => const CustomerRegisterPage(),
      ),
      GoRoute(
        path: '/executor/home',
        builder: (context, state) => const ExecutorHomePage(),
      ),
      GoRoute(
        path: '/executor/order/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return OrderDetailPage(orderId: id, isExecutor: true);
        },
      ),
      GoRoute(
        path: '/executor/chat/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ChatPage(chatId: id);
        },
      ),
      GoRoute(
        path: '/customer/create-order',
        builder: (context, state) => const CreateOrderPage(),
      ),
      GoRoute(
        path: '/customer/home',
        builder: (context, state) => const CustomerHomePage(),
      ),
      GoRoute(
        path: '/customer/specialists',
        builder: (context, state) => const SpecialistsPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => _orderRepository),
        RepositoryProvider(create: (_) => _authRepository),
        RepositoryProvider(create: (_) => _specialistRepository),
        RepositoryProvider(create: (_) => _subscriptionRepository),
        RepositoryProvider(create: (_) => _chatRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => OrdersCubit(getOrders: GetOrders(_orderRepository), getOrderDetail: GetOrderDetail(_orderRepository))..loadOrders()),
          BlocProvider(create: (_) => AuthCubit(Login(_authRepository))),
          BlocProvider(create: (_) => SpecialistsCubit(GetSpecialists(_specialistRepository))..load()),
          BlocProvider(create: (_) => SubscriptionCubit(_subscriptionRepository)),
          BlocProvider(create: (_) => ChatCubit(getMessages: GetMessages(_chatRepository), sendMessage: SendMessage(_chatRepository))),
          BlocProvider(create: (_) => CreateOrderCubit(CreateOrderUseCase(_orderRepository))),
        ],
        child: MaterialApp.router(
          title: 'Master Sairam',
          theme: buildTheme(),
          routerConfig: _router,
        ),
      ),
    );
  }
}
