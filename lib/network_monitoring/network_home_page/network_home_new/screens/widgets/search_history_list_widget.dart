import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';

// State provider for hovered index
final hoveredIndexProvider = StateProvider<int?>((ref) => null);

class SearchHistoryList extends ConsumerStatefulWidget {
  const SearchHistoryList({super.key});

  @override
  _SearchHistoryListState createState() => _SearchHistoryListState();
}

class _SearchHistoryListState extends ConsumerState<SearchHistoryList> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final hoveredIndex = ref.watch(hoveredIndexProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Container(
        width: 280,
        height: math.max(screenHeight * 0.91, 400),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(50, 50, 50, 1),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Last Searches:',
                style: TextStyle(
                  color: Color.fromRGBO(145, 145, 145, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return MouseRegion(
                    onEnter: (_) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (hoveredIndex != index) {
                          ref.read(hoveredIndexProvider.notifier).state = index;
                        }
                      });
                    },
                    onExit: (_) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ref.read(hoveredIndexProvider.notifier).state = null;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      color: hoveredIndex == index
                          ? const Color.fromRGBO(70, 70, 70, 1)
                          : Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListTile(
                        leading: const Icon(
                          Icons.access_time_rounded,
                          size: 15,
                          color: Color.fromRGBO(145, 145, 145, 1),
                        ),
                        title: const Text(
                          'Bialy Kamien Street blabla blaaaaa',
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Color.fromRGBO(233, 233, 233, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: hoveredIndex == index
                            ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: SvgPicture.asset(AppIcons.pencil,
                                  height: 16,
                                      width: 16,
                                  color: Colors.white),
                              onPressed: () {},
                            ),
                            const Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}