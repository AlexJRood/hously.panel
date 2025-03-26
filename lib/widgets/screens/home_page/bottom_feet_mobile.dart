import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/design.dart';

class BottomFeetMobile extends ConsumerWidget {
  const BottomFeetMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentthememode = ref.watch(themeProvider);

    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);
    final themecolors = ref.watch(themeColorsProvider);
    final textFieldColor = themecolors.textFieldColor;
    return Container(
      height: 650,
      width: double.infinity,
      color: currentthememode == ThemeMode.system
          ? AppColors.dark50
          : currentthememode == ThemeMode.light
              ? AppColors.light50
              : AppColors.dark50,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      Text('Jak to dziala?'.tr,
                          style: AppTextStyles.interMedium14
                              .copyWith(fontSize: 18, color: textFieldColor)),
                      const SizedBox(height: 20),
                      Text('Sprawdź ofertę'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Co możesz zyskać?'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(height: 20),
                      Text('Rejstracja profesjonalna, Hously.pro',
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Wsparcie dla rozpoczynających\nprzygodę z hously'.tr,
                        style: AppTextStyles.interLight
                            .copyWith(color: textFieldColor),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      Text('Sprawdź ofertę'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Co możesz zyskać?'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(
                        height: 75,
                      ),
                      Text('Dla profesjonalistów'.tr,
                          style: AppTextStyles.interMedium14
                              .copyWith(fontSize: 18, color: textFieldColor)),
                      const SizedBox(height: 20),
                      Text('Sprawdź ofertę'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Co możesz zyskać?'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text('o nas, Hously.ai',
                          style: AppTextStyles.interMedium14
                              .copyWith(fontSize: 18, color: textFieldColor)),
                      const SizedBox(height: 20),
                      Text('Kontakt'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Co możesz zyskać?'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(height: 20),
                      Text('Sprawdź ofertę'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Co możesz zyskać?'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(
                        height: 75,
                      ),
                      Text('Dla Inwestorów'.tr,
                          style: AppTextStyles.interMedium14
                              .copyWith(fontSize: 18, color: textFieldColor)),
                      const SizedBox(height: 20),
                      Text('Sprawdź ofertę'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Co możesz zyskać?'.tr,
                          style: AppTextStyles.interLight
                              .copyWith(color: textFieldColor)),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Row(
              children: [
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.facebook,
                        color: isDefaultDarkSystem
                            ? Theme.of(context).iconTheme.color
                            : Theme.of(context).primaryColor)),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.face,
                        color: isDefaultDarkSystem
                            ? Theme.of(context).iconTheme.color
                            : Theme.of(context).primaryColor)),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.one_x_mobiledata,
                        color: isDefaultDarkSystem
                            ? Theme.of(context).iconTheme.color
                            : Theme.of(context).primaryColor)),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.youtube_searched_for_sharp,
                        color: isDefaultDarkSystem
                            ? Theme.of(context).iconTheme.color
                            : Theme.of(context).primaryColor)),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.facebook,
                        color: isDefaultDarkSystem
                            ? Theme.of(context).iconTheme.color
                            : Theme.of(context).primaryColor)),
                const SizedBox(
                  width: 20,
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
