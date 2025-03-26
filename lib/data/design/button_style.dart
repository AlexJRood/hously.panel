import 'package:flutter/material.dart';
import 'package:hously_flutter/data/design/design.dart';

final elevatedButtonStyle = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  padding: EdgeInsets.zero,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
  ),
  elevation: 0,
);
final textButtonWithButtonStyle = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: AppColors.textbuttonBackgroundColor,
  surfaceTintColor: AppColors.textbuttonBackgroundColor,
  padding: EdgeInsets.zero,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
  ),
  elevation: 0,
);

final elevatedButtonStyleRounded = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  padding: EdgeInsets.zero,
  elevation: 0,
);

final elevatedButtonStyleRounded10 = ElevatedButton.styleFrom(
  minimumSize: Size.zero,
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  elevation: 0,
);

final elevatedButtonStyleRounded10Vertical = ElevatedButton.styleFrom(
  minimumSize: Size.zero,
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  padding: const EdgeInsets.symmetric(vertical: 10),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  elevation: 0,
);

final elevatedButtonStyleRounded10WithPaddingVertical = ElevatedButton.styleFrom(
  minimumSize: Size.zero,
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  elevation: 0,
);

final elevatedButtonStyleRounded5 = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: AppColors.dark,
  backgroundColor: AppColors.light,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  padding: const EdgeInsets.all(0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
  elevation: 0,
);

final elevatedButtonStyleRounded8 = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: AppColors.dark,
  backgroundColor: AppColors.light,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  padding: const EdgeInsets.all(0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  elevation: 0,
);

final elevatedButtonStyleRounded20 = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  padding: EdgeInsets.zero,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  elevation: 0,
);

final elevatedButtonStyleAddCrm = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  padding: EdgeInsets.zero,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  elevation: 0,
);

final buttonSearchBar = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.dark,
  padding: const EdgeInsets.all(25),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  elevation: 0,
);

final loginButton = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: AppColors.light,
  surfaceTintColor: AppColors.dark,
  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  elevation: 0,
);

final logoutButton = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.dark,
  padding: const EdgeInsets.symmetric(horizontal: 35),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  elevation: 0,
);


final elevatedButtonStyleWithSelect = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  padding: EdgeInsets.zero,
  elevation: 0,
);

final elevatedButtonStyleRounded10SocialLogin = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.light.withOpacity(0.3),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  elevation: 0,
);

final buttonAddForm = ElevatedButton.styleFrom(
  shadowColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  surfaceTintColor: AppColors.dark,
  padding: const EdgeInsets.all(20),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  elevation: 0,
);

final buttonSideDashboard = ElevatedButton.styleFrom(
  shadowColor: AppColors.dark,
  foregroundColor: AppColors.dark50,
  backgroundColor: AppColors.dark50,
  surfaceTintColor: AppColors.dark,
  padding: const EdgeInsets.all(20),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  elevation: 0,
);
