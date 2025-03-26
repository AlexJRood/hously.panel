import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class LanguageTile extends ConsumerStatefulWidget {
  final bool isPc;
  final int index;
  final String countryname;
  final String countrycode;
  final void Function()? onTap;
  final int? groupValue; // Added groupValue to manage selection

  const LanguageTile({
    super.key,
    this.isPc = true,
    required this.onTap,
    required this.index,
    required this.countryname,
    required this.countrycode,
    required this.groupValue, // Receive groupValue from parent
  });

  @override
  ConsumerState<LanguageTile> createState() => _LanguageTileState();
}

class _LanguageTileState extends ConsumerState<LanguageTile> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: widget.index == widget.groupValue
              ? widget.isPc
                  ? theme.mobileTextcolor
                  : theme.settingsMenutile
              : widget.isPc
                  ? theme.mobileTextcolor.withOpacity(0.6)
                  : theme.settingsMenutile.withOpacity(0.6),
          borderRadius: BorderRadius.circular(5),
        ),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<int>(
              value: widget.index,
              groupValue: widget.groupValue,
              activeColor: theme.mobileTextcolor,
              onChanged: (int? value) {
                if (widget.onTap != null) widget.onTap!();
              },
            ),
            const SizedBox(width: 10),
            Text(widget.countryname,
                style: TextStyle(color: theme.mobileTextcolor)),
            const Spacer(),
            CountryFlag.fromCountryCode(
              widget.countrycode,
              width: 30,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
