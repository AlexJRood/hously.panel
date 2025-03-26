import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class NoEventWidget extends ConsumerWidget {
  final bool isPc;
  const NoEventWidget({super.key, required this.isPc});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    final secondContainerwidthmobile = screenWidth * (1100 / 1920);
    final firstContainerwidthmobile = screenWidth * (900 / 1920);
    final secondContainerwidthPc = screenWidth * (220 / 1920);
    final firstContainerwidthmobiPC = screenWidth * (150 / 1920);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: theme.clientplaceholdercolor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 61, 61, 61))),
                  padding: const EdgeInsets.only(
                      top: 12, bottom: 2, left: 2, right: 2),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 100,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.white54,
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: Offset(1, -1))
                        ],
                        border: Border.all(
                            color: const Color.fromARGB(255, 61, 61, 61)),
                        borderRadius: BorderRadius.circular(10),
                        color: theme.textFieldColor),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: isPc
                                  ? firstContainerwidthmobiPC
                                  : firstContainerwidthmobile,
                              decoration: BoxDecoration(
                                  color: theme.fillColor,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            const Spacer()
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: isPc
                                  ? secondContainerwidthPc
                                  : secondContainerwidthmobile,
                              decoration: BoxDecoration(
                                  color: theme.popupcontainercolor,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Spacer()
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 98,
                  left: 10,
                  child: Icon(
                    Icons.more_horiz_rounded,
                    size: 25,
                    color: theme.fillColor,
                  ),
                ),
                Positioned(
                  right: 25,
                  bottom: 3,
                  child: Transform.rotate(
                    angle: 450 *
                        3.1415927 /
                        360, // Rotation in radians (45 degrees)

                    child: Icon(
                      Icons.send_rounded,
                      size: 30,
                      color: theme.fillColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Text(
            "New Event",
            style: TextStyle(color: theme.whitewhiteblack, fontSize: 15),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "Create and manage events seamlessly in one place",
                    style:
                        TextStyle(color: theme.whitewhiteblack, fontSize: 11)),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(theme.clientbuttoncolor),
                  shape: WidgetStatePropertyAll((RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ))),
                ),
                icon: Icon(
                  Icons.add,
                  color: theme.fillColor,
                  size: 14,
                ),
                label: Text(
                  "Add New Event",
                  style: TextStyle(fontSize: 10, color: theme.fillColor),
                ),
                onPressed: () {},
              ))
            ],
          )
        ],
      ),
    );
  }
}
