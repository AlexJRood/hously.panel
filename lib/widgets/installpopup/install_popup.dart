import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';

final popupVisibleProvider = StateProvider<bool>((ref) => false);
final popupActiveProvider = StateProvider<bool>(
    (ref) => false); // new provider to track if the popup is active

void showTopDialog(BuildContext context, WidgetRef ref) {
  double screenWidth = MediaQuery.of(context).size.width;

  const double maxWidth = 1920;
  const double minWidth = 480;

  const double maxLogoSize = 30;
  const double minLogoSize = 16;
  double logoSize = (screenWidth - minWidth) /
          (maxWidth - minWidth) *
          (maxLogoSize - minLogoSize) +
      minLogoSize;

  // Only show the popup if it's not already showing
  if (ref.read(popupActiveProvider) == false) {
    ref.read(popupActiveProvider.notifier).state = true;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            elevation: 5,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color.fromARGB(153, 255, 252, 252).withOpacity(0.5),
                    const Color.fromARGB(255, 211, 211, 211).withOpacity(0.6),
                    const Color.fromARGB(255, 181, 181, 181).withOpacity(0.4),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              height: 300,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                      const Spacer(),
                      Text('HOUSLY.AI',
                          style: AppTextStyles.houslyAiLogo.copyWith(
                              fontSize: logoSize, color: Colors.white)),
                    ],
                  ),
                  Text('hey ! Install Mobile App',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 10),
                  const Text(
                    'Installing the native app provides a smoother experience, faster performance, and access to exclusive features. Track your favorite properties, get personalized notifications, and enjoy seamless navigation designed specifically for your device.',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                                width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                                width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Go to App store",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeInOut)),
          child: child,
        );
      },
    ).then((_) {
      // After the dialog is dismissed, set the popupActiveProvider to false
      ref.read(popupActiveProvider.notifier).state = false;
    });
  }
}

class PopupListener extends ConsumerWidget {
  final Widget child;

  const PopupListener({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popupVisible = ref.watch(popupVisibleProvider);

    if (popupVisible == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (kIsWeb) {
          showTopDialog(context, ref);
          ref.read(popupVisibleProvider.notifier).state = false;
        }
      });
    }

    return child;
  }
}
