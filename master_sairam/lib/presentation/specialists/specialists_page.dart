import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_button.dart';
import '../widgets/app_card.dart';
import 'cubit/specialists_cubit.dart';

class SpecialistsPage extends StatelessWidget {
  const SpecialistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialistsCubit, SpecialistsState>(
      builder: (context, state) {
        if (state is SpecialistsLoading) return const Center(child: CircularProgressIndicator());
        if (state is SpecialistsLoaded) {
          return ListView(
            padding: const EdgeInsets.all(AppConstants.padding),
            children: state.specialists
                .map(
                  (s) => AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(backgroundImage: NetworkImage(s.avatar ?? 'https://via.placeholder.com/80')),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                                  Text(s.categories.join(', ')),
                                  Text('${s.experience} лет опыта'),
                                ],
                              ),
                            ),
                            Text('${s.rate.toStringAsFixed(0)}₸/час'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (s.bio != null) Text(s.bio!),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: CustomButton(label: 'Написать', onPressed: () => context.go('/executor/chat/${s.id}'))),
                            const SizedBox(width: 8),
                            OutlinedButton(onPressed: () {}, child: const Text('Открыть контакты')),
                          ],
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
