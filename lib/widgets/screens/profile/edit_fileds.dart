import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:intl/intl.dart';

class BuildDropdownButtonFormField extends ConsumerWidget {
  const BuildDropdownButtonFormField({
    super.key,
    required this.controller,
    required this.items,
    required this.labelText,
  });
  final TextEditingController controller;
  final List<String> items;
  final String labelText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: DropdownButtonFormField<String>(
        value: controller.text.isNotEmpty ? controller.text : null,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelStyle: AppTextStyles.interRegular
              .copyWith(fontSize: 14, color: AppColors.dark50),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: AppColors.dark)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: AppColors.mapMarker)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: AppColors.superbee)),
          filled: true, // Dodane
          fillColor: Colors.white, // Ustawienie białego tła
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppTextStyles.interRegular
                  .copyWith(fontSize: 14, color: AppColors.dark),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller.text = newValue ?? '';
        },
        // Stylowanie wybranego elementu
        selectedItemBuilder: (BuildContext context) {
          return items.map<Widget>((String value) {
            return Text(value,
                style: AppTextStyles.interSemiBold.copyWith(
                    fontSize: 14,
                    color: AppColors.dark)); // Styl dla wybranego elementu
          }).toList();
        },
      ),
    );
  }
}

class BuildSelectableButtonsFormField extends StatelessWidget {
  const BuildSelectableButtonsFormField({
    super.key,
    required this.controller,
    required this.options,
    required this.labelText,
  });

  final TextEditingController controller;
  final List<String> options;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            labelText,
            style: AppTextStyles.interRegular
                .copyWith(fontSize: 14, color: AppColors.light),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Wrap(
          spacing: 8, // Odstęp między przyciskami
          runSpacing: 8,
          children: options.map((option) {
            return ElevatedButton(
              onPressed: () {
                controller.text =
                    option; // Aktualizacja kontrolera wybraną wartością
                // Odświeżenie stanu, aby zaktualizować UI
                (context as Element).markNeedsBuild();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.text == option
                    ? Colors.blue
                    : Colors.white, // Zmiana koloru dla wybranej opcji
                foregroundColor: controller.text == option
                    ? AppColors.light
                    : AppColors.dark, // Zmiana koloru tekstu
                textStyle: AppTextStyles.interRegular.copyWith(
                    fontSize: 14), // Stosowanie wybranego stylu tekstu
              ),
              child: Text(option),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class AdditionalInfoFilterButton extends StatelessWidget {
  final String text;
  final ValueNotifier<bool> controller;

  const AdditionalInfoFilterButton({
    super.key,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller,
      builder: (_, isSelected, __) {
        return ElevatedButton(
          onPressed: () => controller.value = !isSelected,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.blue : Colors.white,
            foregroundColor: isSelected ? Colors.white : Colors.black,
            side: isSelected ? null : const BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          child: Text(text,
              style:
                  TextStyle(color: isSelected ? Colors.white : Colors.black)),
        );
      },
    );
  }
}

class EstateTypeAddButton extends ConsumerWidget {
  final String text;
  final String filterValue;
  final TextEditingController controller;

  const EstateTypeAddButton({
    super.key,
    required this.text,
    required this.filterValue,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sprawdzanie, czy wartość przycisku jest aktualnie wybrana
    bool isSelected = controller.text == filterValue;

    return ElevatedButton(
      onPressed: () {
        // Jeśli przycisk jest już zaznaczony, to kliknięcie go ponownie powinno usunąć selekcję
        if (isSelected) {
          controller.text =
              ''; // Czyszczenie kontrolera, jeśli wartość jest już zaznaczona
        } else {
          // Ustawienie kontrolera na wartość przycisku, niezależnie od poprzedniego stanu
          controller.text = filterValue;
        }
        // Zmuszenie interfejsu do odświeżenia i pokazania aktualnego stanu
        (context as Element).markNeedsBuild();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Colors.blue
            : Colors.white, // Podświetlenie przycisku, gdy jest wybrany
        foregroundColor: isSelected
            ? Colors.white
            : Colors.black, // Zmiana koloru tekstu w zależności od stanu
        side: isSelected
            ? null
            : const BorderSide(
                color: Colors
                    .grey), // Dodanie obramowania dla niezaznaczonych przycisków
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18.0)), // Zaokrąglenie rogów przycisku
      ),
      child: Text(text,
          style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Colors
                      .black)), // Zmiana koloru tekstu w zależności od stanu
    );
  }
}

class ButtonOption {
  final String label;
  final String value;

  const ButtonOption(this.label, this.value);
}

class SelectButtonsOptions extends StatelessWidget {
  const SelectButtonsOptions({
    super.key,
    required this.controller,
    required this.options,
    required this.labelText,
  });

  final TextEditingController controller;
  final List<ButtonOption> options;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            labelText,
            style: AppTextStyles.interRegular
                .copyWith(fontSize: 14, color: AppColors.light),
          ),
        ),
        Wrap(
          spacing: 8.0, // Odstęp między przyciskami
          runSpacing: 8.0,
          children: options.map((option) {
            return ValueListenableBuilder(
              valueListenable: controller, // Listen to the controller's text
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: () {
                    controller.text = option.label;
                    print(controller.text);
                     // Update the controller with the selected value
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.text == option.label
                        ? Colors.blue
                        : Colors.white, // Color for selected option
                    foregroundColor: controller.text == option.label
                        ? Colors.white
                        : Colors.black, // Text color
                  ),
                  child: Text(option.label),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}



class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.maxLines,
    this.validator,
  });
  final TextEditingController controller;
  final String labelText;
  final int? maxLines;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.interRegular
          .copyWith(fontSize: 14, color:Colors.black),
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        labelText: labelText,
        labelStyle: AppTextStyles.interRegular
            .copyWith(fontSize: 14, color: AppColors.light),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColors.light)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColors.light)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColors.superbee)),
      ),
      maxLines:
          maxLines ?? 1, // Domyślnie jedna linia, chyba że określono inaczej
      validator: validator,
    );
  }
}

class BuildTextFieldDes extends StatelessWidget {
  const BuildTextFieldDes({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
  });
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.interRegular
          .copyWith(fontSize: 14, color: AppColors.dark),
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        labelText: labelText,
        labelStyle: AppTextStyles.interRegular
            .copyWith(fontSize: 14, color: AppColors.light),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColors.light)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColors.light)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: AppColors.superbee)),
        counterText: '', // Ukrywa licznik znaków
      ),
      maxLines:
          null, // Pozwala na dowolną liczbę linii, pole rozszerza się wertykalnie
      maxLength: 2500, // Ogranicza liczbę znaków do 2500
      validator: validator,
    );
  }
}

class BuildNumberTextField extends StatelessWidget {
  const BuildNumberTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    required this.unit,
  });
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator? validator;
  final String unit; // Parametr dla jednostki

  @override
  Widget build(BuildContext context) {
    // Ustawienie NumberFormat z separatorem w postaci spacji
    final formatter = NumberFormat('#,###.##', 'pl_PL');
    // Określenie koloru wypełnienia na podstawie wartości kontrolera
    Color fillColor = controller.text.isEmpty ? Colors.white : Colors.white;

    return TextFormField(
      style: AppTextStyles.interSemiBold
          .copyWith(fontSize: 14, color: AppColors.dark),
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        labelText: labelText,
        labelStyle: AppTextStyles.interRegular
            .copyWith(fontSize: 14, color: AppColors.dark50),
        filled: true, // Włączenie wypełnienia kolorem
        fillColor: fillColor, // Ustawienie koloru wypełnienia
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: AppColors.dark)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: AppColors.light)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: AppColors.superbee)),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Dopuszcza tylko cyfry
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.isEmpty) {
            return newValue.copyWith(text: '');
          }
          final int value =
              int.parse(newValue.text.replaceAll(' ', '').replaceAll(',', ''));
          final String newText = formatter.format(value).replaceAll(',', ' ');
          return newValue.copyWith(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length),
          );
        }),
      ],
      validator: validator,
    );
  }
}

class UnitInputFormatter extends TextInputFormatter {
  final String unit;

  UnitInputFormatter({required this.unit});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText =
        newValue.text.replaceAll(',', '.'); // Zamiana przecinka na kropkę

    if (newText.isNotEmpty && !newText.endsWith(unit)) {
      // Jeśli nowy tekst nie kończy się jednostką, dodaj ją
      newText += ' $unit';
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
          offset:
              newText.length - unit.length - 1), // Aktualizacja pozycji kursora
    );
  }
}
