import 'package:bookify/view_models/professional_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceFilterBottomSheet extends ConsumerWidget {
  const PriceFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterStateProvider);
    final maxPrice = filterState.maxPrice;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set Maximum Price',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'R ${maxPrice.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Slider(
            value: maxPrice,
            min: 0,
            max: 3000,
            divisions: 30,
            label: 'R ${maxPrice.toStringAsFixed(0)}',
            onChanged: (value) {
              ref.read(filterStateProvider.notifier).setMaxPrice(value);
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('APPLY'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
