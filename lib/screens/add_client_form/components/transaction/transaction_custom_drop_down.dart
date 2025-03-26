import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/screens/add_client_form/provider/transaction_provider.dart';

class DropdownState {
  final String selectedValue;
  DropdownState({required this.selectedValue});
}

class DropdownNotifier extends StateNotifier<Map<int, DropdownState>> {
  DropdownNotifier() : super(<int, DropdownState>{});

  void updateSelectedValue(int id, String newValue, String valueKey, WidgetRef ref) {
    state = {...state}..[id] = DropdownState(selectedValue: newValue);
        ref.read(agentTransactionCacheProvider.notifier).addTransactionData(valueKey, newValue);

  }
}

final agentTransactionDropDownProvider =
    StateNotifierProvider<DropdownNotifier, Map<int, DropdownState>>((ref) {
  return DropdownNotifier();
});

class AgentTransactionFormCustomDropDown extends ConsumerWidget {
  final int id;
  final List<String> options;
  final String hintText;
  final String valueKey;

  const AgentTransactionFormCustomDropDown({
    super.key,
    required this.id,
    required this.options,
    required this.hintText,
    required this.valueKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownMap = ref.watch(agentTransactionDropDownProvider);
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
              ref.read(agentTransactionDropDownProvider.notifier)
                  .updateSelectedValue(id, newValue, valueKey, ref);

            }
          },
          icon: SvgPicture.asset(AppIcons.iosArrowDown, color: Colors.white),
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
