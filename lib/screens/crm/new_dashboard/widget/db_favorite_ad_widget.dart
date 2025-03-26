import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hously_flutter/network_monitoring/components/cards/real_state_and_home_for_sale_card.dart';
import 'package:hously_flutter/network_monitoring/components/cards/va.dart';

class DbFavoriteAdWidget extends StatelessWidget {
  final bool isMobile;
  const DbFavoriteAdWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Favourite Advertisment',
                style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              spacing: 10,
              children: [
                if (!isMobile)
                  Text('View browse list',
                      style: TextStyle(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700)),
                Container(
                  width: 74.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: const Color.fromRGBO(79, 79, 79, 1))),
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        size: 18.sp,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                      Text('Filter',
                          style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        if (!isMobile)
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 1;

              if (constraints.maxWidth > 600) {
                crossAxisCount = 2;
              }
              if (constraints.maxWidth > 1000) {
                crossAxisCount = 3;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Prevents scrolling conflicts
                padding: const EdgeInsets.all(10),
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return const RealStateAndHomeForSaleCard(
                    isMobile: false, ad: null, keyTag: '',
                  );
                },
              );
            },
          ),
        if (isMobile)
          SizedBox(
            height: 500.h,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              shrinkWrap: true,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  const RealStateAndHomeForSaleCard(
                isMobile: true, ad: null, keyTag: '',
              ),
            ),
          )
      ],
    );
  }
}
