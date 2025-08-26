import 'package:bookify/core/theme/theme_config.dart';
import 'package:bookify/core/utils/app_animations/app_animations.dart';
import 'package:bookify/core/utils/app_butons/active_button.dart';
import 'package:bookify/core/utils/app_font_size/app_font_size.dart';
import 'package:bookify/view_models/time_slots_provider.dart';
import 'package:bookify/widgets/custom_message_widget/custom_message_widget.dart';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({super.key});

  @override
  ConsumerState<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends ConsumerState<BooksScreen> {
  List<String> selectedValue = [];

  void setSelectedValue(List<String> value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final timeSlotsAsync = ref.watch(timeSlotListProvider);

    return Container(
      height: screenSize.height * 0.5,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppFontSize.fontSize20),
          topRight: Radius.circular(AppFontSize.fontSize20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppFontSize.fontSize12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose a time', style: theme().textTheme.displaySmall),
            Expanded(
              child: timeSlotsAsync.when(
                data: (slots) {
                  return InlineChoice(
                    itemCount: slots.length,
                    clearable: true,
                    value: selectedValue,
                    onChanged: setSelectedValue,
                    itemBuilder: (selection, i) {
                      return ChoiceChip(
                        selected: selection.selected(slots[i].toString()),
                        onSelected: selection.onSelected(slots[i].toString()),
                        label: Text(slots[i].time),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => CustomMessageWidget(
                  animation: AppAnimations.errorAnimation,
                  errorMessage: 'Error loading time slot',
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width,
              child: ActiveButton(
                buttonText: 'Continue',
                keyText: null,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
