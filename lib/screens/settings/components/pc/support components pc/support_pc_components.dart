import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';

class Supportile extends ConsumerWidget {
  final IconData iconData;
  final String title;
  final String description;

  const Supportile({
    super.key,
    required this.iconData,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 180,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient:
              CustomBackgroundGradients.appBarGradientcustom(context, ref),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(iconData,color: Theme.of(context).iconTheme.color,),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                const SizedBox(height: 10),
                Divider(
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.7),
                )
              ],
            ),
            Text(
              description,
              maxLines: 5,
              style: TextStyle(
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.9)),
            )
          ],
        ),
      ),
    );
  }
}
