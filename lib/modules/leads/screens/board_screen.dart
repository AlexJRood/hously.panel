import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/board/board.dart';
import 'package:hously_flutter/widgets/bars/bar_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';


class DraggableBoardPc extends ConsumerStatefulWidget {
  const DraggableBoardPc({super.key});

  @override
  ConsumerState<DraggableBoardPc> createState() =>
      _DraggableBoardState();
}

class _DraggableBoardState extends ConsumerState<DraggableBoardPc> {

  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {

    return BarManager(
    sideMenuKey: sideMenuKey,
      children: [
       LeadBoard(ref: ref),
    ],
    );
    
  }
}
