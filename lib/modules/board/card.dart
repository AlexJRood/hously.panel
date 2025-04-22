import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/theme/icons2.dart';

class LeadCardBoard extends StatelessWidget {
  final Lead transaction;
  final String? activeSection;
  final bool isSeller;
  final bool isMoved;
  const LeadCardBoard(
      {super.key, required this.transaction, this.activeSection, this.isSeller = true, this.isMoved =false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:5.0),
      child: Container(
          height: 175,
          width: 300,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isMoved? AppColors.backgroundgradient2 : (isSeller ? AppColors.dark75 : AppColors.dark25) ,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(transaction.name.toString(),
                      style: AppTextStyles.interMedium16),
                  AppIcons.moreVertical(color: Color.fromRGBO(145, 145, 145, 1),
                  )
                ],
              ),
              Text(
                // '${transaction.street},${transaction.city}',
                '',
                style: TextStyle(
                    color: Color.fromRGBO(145, 145, 145, 1),
                    fontSize: 11,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions Type ',
                    style: TextStyle(
                        color: Color.fromRGBO(145, 145, 145, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    // transaction.transactionType,
                    '',
                    style: TextStyle(
                        color: Color.fromRGBO(233, 233, 233, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount',
                    style: TextStyle(
                        color: Color.fromRGBO(145, 145, 145, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    // transaction.amount,
                    '',
                    style: TextStyle(
                        color: Color.fromRGBO(233, 233, 233, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Commission',
                    style: TextStyle(
                        color: Color.fromRGBO(145, 145, 145, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    // transaction.commission,
                    '',
                    style: TextStyle(
                        color: Color.fromRGBO(233, 233, 233, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),             
            ],
          )),
    );
  }
}
