import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/theme/colors.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/utils/extensions/context_extension.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class CheckBoxText extends ConsumerWidget {
  final bool isActive;
  final String title;
  final ValueChanged<bool> onChanged;
  final double fontSize;
  final Widget? titleWidget;
  final CrossAxisAlignment crossAxisAlignment;

  const CheckBoxText({
    super.key,
    required this.isActive,
    required this.title,
    required this.onChanged,
    this.fontSize = 18,
    this.titleWidget,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        CheckboxWidget(
          color: Theme.of(context).iconTheme.color,
          isActive: isActive,
          onChanged: onChanged,
          width: context.isMobile ? 22 : 27,
          height: context.isMobile ? 22 : 27,
        ),
        const SizedBox(width: 20),
        if (titleWidget == null)
          SizedBox(
            child: Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  fontSize: context.isMobile ? null : fontSize,
                  fontFamily: 'RobotoRegular',
                  color: const Color.fromRGBO(255, 255, 255, 1)),
            ),
          )
        else
          titleWidget!,
      ],
    );
  }
}

class CheckboxWidget extends ConsumerWidget {
  const CheckboxWidget({
    super.key,
    this.width = 22.0,
    this.height = 22.0,
    this.color,
    this.iconSize = 14,
    this.onChanged,
    required this.isActive,
  });

  final double width;
  final double height;
  final Color? color;
  final double iconSize;
  final bool isActive;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => onChanged?.call(!isActive),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: color ?? Colors.white),
          color: isActive ? Theme.of(context).primaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: isActive
            ? SvgPicture.asset(AppIcons.check,
                height: iconSize,width: iconSize, color: Theme.of(context).iconTheme.color)
            : null,
      ),
    );
  }
}
