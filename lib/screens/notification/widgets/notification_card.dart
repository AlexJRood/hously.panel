import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/screens/notification/model/notification_model.dart';
import 'package:hously_flutter/screens/notification/widgets/image_details_widget.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: SvgPicture.asset(AppIcons.notification, color: Colors.white),
        title: Text(
          notification.title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          notification.text,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: notification.image != null
            ? Hero(
                tag: notification.image!,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) =>
                            ImageDetailWidget(imageUrl: notification.image!),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      notification.image!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : const Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    );
  }
}
