import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class DeviceInfoWidget extends ConsumerWidget {
  final String deviceName;
  final String locationAndDate;
  final bool ismac;
  final bool isPc;
  final void Function()? onPressed;
  const DeviceInfoWidget({
    Key? key,
    this.isPc = true,
    required this.onPressed,
    this.ismac = false,
    required this.deviceName,
    required this.locationAndDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final currentmode = ref.watch(isDefaultDarkSystemProvider);
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: currentmode
              ? theme.deviceinfocolor
              : Theme.of(context).primaryColor,
          child: Icon(
              ismac ? Icons.desktop_mac_outlined : Icons.phone_iphone_rounded,
              color: Theme.of(context).iconTheme.color),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deviceName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isPc
                      ? Theme.of(context).iconTheme.color
                      : theme.popupcontainertextcolor,
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(locationAndDate,
                  style: TextStyle(
                    color: isPc
                        ? Theme.of(context).iconTheme.color
                        : theme.popupcontainertextcolor,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.close_rounded,
              size: 14,
              color: isPc
                  ? Theme.of(context).iconTheme.color
                  : theme.popupcontainertextcolor,
            )),
      ],
    );
  }
}
