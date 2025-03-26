import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/portal/browselist/utils/api.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';


class BrowseListActionsWidget extends ConsumerWidget {
  final bool isHidden;
  final VoidCallback toggleIsHidden;
  const BrowseListActionsWidget({
    super.key,
    required this.isHidden,
    required this.toggleIsHidden,
    });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child:  Container(
            color: Colors.black26,
            child: ElevatedButton(
                    style: elevatedButtonStyleRounded10,
              onPressed: () async {
                await ref.read(browseListProvider.notifier).clearBrowseLists();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Lista przeglądania wyczyszczona'.tr),
                  ),
                );
                // Możesz dodatkowo odświeżyć listę, np. wywołując applyFilters() lub inną metodę
                await ref.read(browseListProvider.notifier).applyFilters(ref);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 5,
                  children: [
                    const Icon(Icons.clear_outlined, size: 20),
                    if(!isHidden)
                      Flexible(child: Text('Wyczyść listę przeglądania'.tr, style: AppTextStyles.interMedium14)), // change to production
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




class BrowseListButtonBarWidget extends StatefulWidget {
  final bool isHidden;
  final VoidCallback toggleIsHidden;

  const BrowseListButtonBarWidget({
    super.key,
    required this.isHidden,
    required this.toggleIsHidden,
  });

  @override
  _BrowseListPcWidgetState createState() => _BrowseListPcWidgetState();
}

class _BrowseListPcWidgetState extends State<BrowseListButtonBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                  style: elevatedButtonStyleRounded10,
                  onPressed: widget.toggleIsHidden,
                  child: Icon(
                    widget.isHidden
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    size: 25,
                  ),
                ),
              ),
              if (!widget.isHidden)
                Flexible(
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Lista przeglądania".tr,
                            style: AppTextStyles.interMedium14,
                        ),
                      const SizedBox(width:10 ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
