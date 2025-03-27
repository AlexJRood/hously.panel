import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color color;

  SubtitleText({
    Key? key,
    this.color = Colors.grey,
    this.fontsize = 12,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color == Colors.grey
            ? Theme.of(context).iconTheme.color!.withOpacity(0.7)
            : color,
        fontSize: fontsize,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class AuthenticationButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;
  final isPc;
  const AuthenticationButton({
    super.key,
    this.isPc = true,
    required this.icon,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed ?? () {},
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 4.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.black54,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black87,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;
  final isPc;
  const PaymentButton({
    super.key,
    this.isPc = true,
    required this.icon,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        height: isPc ? 0 : 50,
        child: ElevatedButton(
          onPressed: onPressed ?? () {},
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 4.0,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the icon and text
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
              const SizedBox(width: 8.0),
              Text(
                text,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
