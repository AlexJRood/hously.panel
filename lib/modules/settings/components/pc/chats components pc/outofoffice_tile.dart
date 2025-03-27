import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class Outofofficetile extends ConsumerWidget {
  const Outofofficetile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    final proTheme = ref.watch(isDefaultDarkSystemProvider);
    return Container(
      decoration: BoxDecoration(
        color: theme.fillColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 2, color: Theme.of(context).iconTheme.color!),
      ),
      child: Container(
        width: 400,
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 20,
                height: 70,
                decoration: BoxDecoration(
                  gradient: CustomBackgroundGradients.proContainerGradient(
                      context, ref),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Expanded(flex: 2, child: SizedBox()),
            Expanded(
              flex: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: 300,
                    decoration: BoxDecoration(
                      gradient: CustomBackgroundGradients.proContainerGradient(
                          context, ref),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 30,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: theme.popupcontainercolor),
                    child: Center(
                      child: Text(
                        'im Currently out of office until [date]',
                        style: TextStyle(
                            color: theme.popupcontainertextcolor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 5),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  gradient: CustomBackgroundGradients.proContainerGradient(
                      context, ref),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
