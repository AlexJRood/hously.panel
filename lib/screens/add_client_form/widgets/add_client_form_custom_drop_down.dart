import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class DropdownState {
  final String selectedValue;
  DropdownState({required this.selectedValue});
}

class DropdownNotifier extends StateNotifier<Map<int, DropdownState>> {
  DropdownNotifier() : super(<int, DropdownState>{});

  void updateSelectedValue(int id, String newValue) {
    state = {...state}..[id] = DropdownState(selectedValue: newValue);
  }
}

final addClientDropDownProvider =
    StateNotifierProvider<DropdownNotifier, Map<int, DropdownState>>((ref) {
  return DropdownNotifier();
});

class AddClientFormCustomDropDown extends ConsumerWidget {
  final int id;
  final List<String> options;
  final String hintText;

  const AddClientFormCustomDropDown({
    super.key,
    required this.id,
    required this.options,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownMap = ref.watch(addClientDropDownProvider);
    final dropdownState = dropdownMap[id] ?? DropdownState(selectedValue: '');

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(35, 35, 35, 1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: dropdownState.selectedValue.isEmpty
              ? const Color.fromRGBO(35, 35, 35, 1)
              : const Color.fromRGBO(200, 200, 200, 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownState.selectedValue.isEmpty
              ? null
              : dropdownState.selectedValue,
          hint: Text(
            hintText,
            style: const TextStyle(
              color: Color.fromRGBO(145, 145, 145, 1),
              fontSize: 12,
            ),
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              ref
                  .read(addClientDropDownProvider.notifier)
                  .updateSelectedValue(id, newValue);
            }
          },
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          dropdownColor: const Color.fromRGBO(35, 35, 35, 1),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          items: options
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
