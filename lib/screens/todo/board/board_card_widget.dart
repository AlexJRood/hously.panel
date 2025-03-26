import 'package:flutter/material.dart';
import 'package:hously_flutter/extensions/context_extension.dart';

class BoardCardWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int notificationCount;
  final List<String> comments;
  final int id;

  const BoardCardWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.notificationCount,
    required this.comments,
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 440,
      width: 540,
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: 400,
            margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                // Title and notification badge
                Positioned(
                  top: 16,
                  left: 16,
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),


                    ],
                  ),
                ),
                // Comments
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: comments
                        .map(
                          (comment) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                comment,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),

              ],
            ),
          ),
          Positioned(
            top: 0,
            right:30,
            child: Container(
              height: 35,
              width: 25,
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  id.toString(),
                  style:  TextStyle(
                      color: Colors.white,
                      fontSize: context.isDesktop?18:14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}