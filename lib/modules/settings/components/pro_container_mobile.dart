import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';

class ProContainer extends ConsumerWidget {
  final String title;
  final String subtitle;

  const ProContainer({
    super.key,
    required this.subtitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context, ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    double fontSize = 16;
    double subFontSize = 12;
    double buttonFontSize = 12;

    return Container(
      height: 130,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: CustomBackgroundGradients.proContainerGradient(context, ref),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title at the top
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).iconTheme.color,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle (max 4 lines, expands if needed)
          Expanded(
            child: Text(
              subtitle,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontSize: subFontSize,
              ),
            ),
          ),

          // Button at the bottom right
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 15,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Go PRO',
                    style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: buttonFontSize,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
