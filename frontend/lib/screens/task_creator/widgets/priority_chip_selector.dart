import 'package:flutter/material.dart';
import 'package:frontend/domain/task_entity.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_state.dart';

class PriorityChipSelector extends StatelessWidget {
  final List<PriorityChip> priorityChips;
  final Function(PriorityValue) onPrioritySelected;

  const PriorityChipSelector({
    Key? key,
    required this.priorityChips,
    required this.onPrioritySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Select Priority',
            style: TextStyle(
              fontFamily: 'JejuGothic',
              fontSize: 24.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: priorityChips.map((priorityChip) => _buildPriorityChip(context, priorityChip)).toList(),
          ),
        ]),
      );

  Widget _buildPriorityChip(BuildContext context, PriorityChip priorityChip) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(
            priorityChip.label,
            style: TextStyle(
              fontFamily: 'JejuGothic',
              fontSize: 16.0,
              color: priorityChip.isSelected ? Colors.black : const Color(0xFF604E5E),
            ),
          ),
          selected: priorityChip.isSelected,
          onSelected: (bool selected) {
            if (selected) {
              onPrioritySelected(priorityChip.priority);
            }
          },
          selectedColor: priorityChip.color,
          backgroundColor: const Color(0xFFD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: priorityChip.isSelected ? const Color(0xFFA68DA4) : const Color(0xFF91778F),
            ),
          ),
        ),
      );
}
