import 'package:bookify/core/theme/theme_config.dart';
import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:bookify/view_models/professional_provider.dart';
import 'package:bookify/widgets/price_filtering_bottom_shhet/price_filtering_bootm_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfessionalFilteringAppbar extends ConsumerWidget {
  const ProfessionalFilteringAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final filterState = ref.watch(filterStateProvider);

    // Define available categories (you could also fetch these from your data)
    final categories = [
      'All',
      'Hair Stylist',
      'Barber',
      'Makeup Artist',
      'Massage Therapist',
      'Nail Technician',
    ];

    return Container(
      width: screenSize.width,
      color: AppColors().primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            Text('Welcome Edward', style: theme().textTheme.displayMedium),

            const SizedBox(height: 12),

            // Filter Chips Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Category Filter Dropdown
                  _FilterChip(
                    label: 'Category: ${filterState.category}',
                    icon: Icons.category,
                    onTap: () {
                      _showCategoryMenu(context, ref, categories);
                    },
                  ),
                  const SizedBox(width: 8),

                  // Max Price Filter
                  _FilterChip(
                    label: 'Max: ${filterState.maxPrice.toInt()}',
                    icon: Icons.attach_money,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const PriceFilterBottomSheet(),
                      );
                    },
                  ),
                  const SizedBox(width: 8),

                  // Travel Mode Filter
                  _FilterChip(
                    label: filterState.canTravel
                        ? 'Travel Only'
                        : 'Any Location',
                    icon: filterState.canTravel
                        ? Icons.directions_car
                        : Icons.location_on,
                    onTap: () {
                      ref
                          .read(filterStateProvider.notifier)
                          .setCanTravel(!filterState.canTravel);
                    },
                  ),
                  const SizedBox(width: 8),

                  // Reset Filters
                  if (filterState.category != 'All' ||
                      filterState.maxPrice < 3000 ||
                      filterState.canTravel)
                    _FilterChip(
                      label: 'Clear All',
                      icon: Icons.clear,
                      onTap: () {
                        ref.read(filterStateProvider.notifier).reset();
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryMenu(
    BuildContext context,
    WidgetRef ref,
    List<String> categories,
  ) {
    final renderBox = context.findRenderObject() as RenderBox?;
    final position = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox!.size.height,
        position.dx + renderBox.size.width,
        position.dy + renderBox.size.height,
      ),
      items: categories.map((category) {
        return PopupMenuItem<String>(value: category, child: Text(category));
      }).toList(),
    ).then((selectedCategory) {
      if (selectedCategory != null) {
        ref.read(filterStateProvider.notifier).setCategory(selectedCategory);
      }
    });
  }
}

// Reusable Filter Chip Widget
class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors().whiteColor.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors().primaryColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors().primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ProfessionalFilteringAppbar extends StatefulWidget {
//   const ProfessionalFilteringAppbar({super.key});

//   @override
//   State<ProfessionalFilteringAppbar> createState() =>
//       _ProfessionalFilteringAppbarState();
// }

// class _ProfessionalFilteringAppbarState
//     extends State<ProfessionalFilteringAppbar> {
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Container(
//       width: screenSize.width,
//       height: 150,
//       color: AppColors().primaryColor,
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           spacing: 10,
//           children: [
//             Text('Welcome Edward', style: theme().textTheme.displayMedium),
//             SizedBox(
//               height: 44,
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: AppColors().whiteColor,
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: AppColors().primaryColor,
//                   ),
//                   hintText: 'Search for professionals',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(35),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
