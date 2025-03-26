import 'package:flutter/material.dart';

class TransActionEventsWidget extends StatelessWidget {
  final bool isMobile;
  const TransActionEventsWidget({super.key,this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 385,
      width: isMobile?null:MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color.fromRGBO(33, 32, 32, 1)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Events',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 32,
                width: 96,
                decoration: BoxDecoration(
                    color:
                    const Color.fromRGBO(79, 79, 79, 1),
                    borderRadius: BorderRadius.circular(6)),
                child: const Center(
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Color.fromRGBO(
                            233, 233, 233, 1),
                        size: 20,
                      ),
                      Text(
                        'Add task',
                        style: TextStyle(
                            color: Color.fromRGBO(
                                233, 233, 233, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                 constraints: const BoxConstraints(
                   minHeight: 74
                 ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(41, 41, 41, 1)),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                          height: 74,
                          child: VerticalDivider()),
                      Expanded(
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10),
                          child: const Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                'Negotiation meeting',
                                style: TextStyle(
                                    color: Color.fromRGBO(
                                        166, 227, 184, 1),
                                    fontSize: 13,
                                    fontWeight:
                                    FontWeight.w500),
                              ),
                              Text(
                                'December 17, 10:30-12:00',
                                style: TextStyle(
                                    color: Color.fromRGBO(
                                        255, 255, 255, 1),
                                    fontSize: 11,
                                    fontWeight:
                                    FontWeight.w500),
                              ),
                              Text(
                                'Location: Warszawa, Mokotów, Poland',
                                style: TextStyle(
                                    color: Color.fromRGBO(
                                        255, 255, 255, 1),
                                    fontSize: 11,
                                    fontWeight:
                                    FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
