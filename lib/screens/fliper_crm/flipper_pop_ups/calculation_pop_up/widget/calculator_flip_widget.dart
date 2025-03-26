import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/calculation_pop_up/widget/calculator_check_step_widget.dart';

class CalculatorFlipWidget extends StatelessWidget {
  const CalculatorFlipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(19, 19, 19, 1),
        border: Border.all(color: const Color.fromRGBO(90, 90, 90, 1)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Flip Calculator',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromRGBO(33, 32, 32, 1)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.share,
                              color: Color.fromRGBO(233, 233, 233, 1),
                            ),
                            Text(
                              'Share',
                              style: TextStyle(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromRGBO(33, 32, 32, 1)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_download_outlined,
                              color: Color.fromRGBO(233, 233, 233, 1),
                            ),
                            Text(
                              'Download',
                              style: TextStyle(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const CalculatorCheckStepWidget(
            title: 'After repair Value',
            number: 1,
            price: '120,000.00',
          ),
          const CalculatorCheckStepWidget(
            title: 'Purchase price',
            number: 2,
            price: '120,000.00',
          ),
          const CalculatorCheckStepWidget(
            title: 'repair costs',
            number: 3,
            price: '120,000.00',
            isLast: true,
          ),
        ],
      ),
    );
  }
}
