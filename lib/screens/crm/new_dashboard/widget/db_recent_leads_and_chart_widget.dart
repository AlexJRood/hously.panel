import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'db_earning_chart_widget.dart';

class DbRecentLeadsAndChartWidget extends StatelessWidget {
  const DbRecentLeadsAndChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 384.h,
            child: Column(
              spacing: 20,
              children: [
                SizedBox(
                  height: 62.h,
                  child: const DbMoneyListView(),
                ),
                const DbRecentLeadsWidget(),
              ],
            ),
          ),
        ),
        const Expanded(child: DbEarningChartWidget())
      ],
    );
  }
}

class DbMoneyListView extends StatelessWidget {
  const DbMoneyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 28.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(33, 32, 32, 1),
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: const Color.fromRGBO(79, 79, 79, 1))),
                child: Center(
                  child: Text(
                    "7,487.48 PLN",
                    style: TextStyle(
                        color: const Color.fromRGBO(166, 227, 184, 1),
                        fontSize: 14.sp),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 28.h,
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(33, 32, 32, 1),
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: const Color.fromRGBO(79, 79, 79, 1))),
                child: Center(
                  child: Text(
                    "7,487.48 PLN",
                    style: TextStyle(
                        color: const Color.fromRGBO(227, 166, 167, 1),
                        fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DbRecentLeadsWidget extends StatelessWidget {
  final bool isMobile;
  const DbRecentLeadsWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: 292.h,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(33, 32, 32, 1), // Dark background
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color.fromRGBO(79, 79, 79, 1),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Leads',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Text(
                  'View All',
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[800],
                        radius: 20.r,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jason Smith",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "jason.s@gmail.com",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ),
                      if (!isMobile) ...[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                [
                                  "New Client to Contact",
                                  "Scheduled Meeting",
                                  "In Negotiation",
                                  "Stopped Responding"
                                ][index],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            [
                              "03/01/2025",
                              "03/01/2025",
                              "03/01/2025",
                              "02/18/2025"
                            ][index],
                            style:
                                TextStyle(color: Colors.grey, fontSize: 13.sp),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            [
                              "'Contact via WhatsApp'",
                              "Wants office with parking",
                              "Negotiating price",
                              "Last call unanswered"
                            ][index],
                            style:
                                TextStyle(color: Colors.grey, fontSize: 13.sp),
                          ),
                        ),
                      ],
                      Icon(Icons.call_outlined,
                          color: Colors.grey, size: 18.sp),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
