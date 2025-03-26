import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardLastMountViewWidget extends StatelessWidget {
  final bool isMobile;
  const DashboardLastMountViewWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: isMobile ? null : 134.h,
      width: isMobile ? screenSize.width : screenSize.width - 40.w,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(33, 32, 32, 1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color.fromRGBO(79, 79, 79, 1))),
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DbLastMountCard(
                    title: "LEADS", value: "26", change: "26%"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                  child: const Divider(
                    color: Color.fromRGBO(79, 79, 79, 1),
                  ),
                ),
                const DbLastMountCard(
                    title: "PROPERTIES SOLD", value: "2", change: "16%"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                  child: const Divider(
                    color: Color.fromRGBO(79, 79, 79, 1),
                  ),
                ),
                const DbLastMountCard(
                    title: "ESTIMATED COMMISSIONS",
                    value: "\$9,7876",
                    change: "26%"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                  child: const Divider(
                    color: Color.fromRGBO(79, 79, 79, 1),
                  ),
                ),
                const DbLastMountCard(
                    title: "CUSTOMERS", value: "6", change: "26%"),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                    child: DbLastMountCard(
                        title: "LEADS", value: "26", change: "26%")),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0.h),
                  child: const VerticalDivider(
                    color: Color.fromRGBO(79, 79, 79, 1),
                  ),
                ),
                const Expanded(
                    child: DbLastMountCard(
                        title: "PROPERTIES SOLD", value: "2", change: "16%")),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0.h),
                  child: const VerticalDivider(
                    color: Color.fromRGBO(79, 79, 79, 1),
                  ),
                ),
                const Expanded(
                    child: DbLastMountCard(
                        title: "ESTIMATED COMMISSIONS",
                        value: "\$9,7876",
                        change: "26%")),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0.h),
                  child: const VerticalDivider(
                    color: Color.fromRGBO(79, 79, 79, 1),
                  ),
                ),
                const Expanded(
                    child: DbLastMountCard(
                        title: "CUSTOMERS", value: "6", change: "26%")),
              ],
            ),
    );
  }
}

class DbLastMountCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  const DbLastMountCard(
      {super.key,
      required this.value,
      required this.title,
      required this.change});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6.h),
          Row(
            spacing: 10.w,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(166, 227, 184, 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_up,
                        color: const Color.fromRGBO(166, 227, 184, 1),
                        size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      change,
                      style: TextStyle(
                          color: const Color.fromRGBO(166, 227, 184, 1),
                          fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Text(
                'from last month',
                style: TextStyle(
                    color: const Color.fromRGBO(145, 145, 145, 1),
                    fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
