import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hously_flutter/utils/loading_widgets.dart';

class PhotoSelector extends ConsumerWidget {
  final String imageUrl;

  const PhotoSelector({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth > 600 ? 130 : 110;
    final userAsyncValue = ref.watch(userProvider);
    final theme = ref.watch(themeColorsProvider);
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        userAsyncValue.when(
          loading: () =>
              const ShimmerPlaceholder(width: 140, height: 140, radius: 10),
          error: (error, stackTrace) =>
              const ShimmerPlaceholder(width: 140, height: 140, radius: 10),
          data: (userData) {
            if (userData == null) {
              return Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: theme.settingstile,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ); // If user data is null, return empty space
            }

            return Container(
              height: 140,
              width: 140,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: userData.avatarUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const ShimmerPlaceholder(
                      width: 140, height: 140, radius: 10),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  /// Error Placeholder for Error State
}

class HeadingText extends ConsumerWidget {
  final String text;
  final Color color;
  final double fontsize;

  HeadingText({
    Key? key,
    this.fontsize = 20,
    this.color = Colors.white, // Default color
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // Use the default theme icon color if color is set to the default (Colors.white)
    return Text(
      text,
      style: TextStyle(
        color:
            color == Colors.white ? Theme.of(context).iconTheme.color : color,
        fontSize: fontsize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class GradientTextField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode reqNode;
  final TextInputType keyboardType;

  const GradientTextField({
    Key? key,
    required this.focusNode,
    required this.reqNode,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  _GradientTextFieldState createState() => _GradientTextFieldState();
}

class _GradientTextFieldState extends ConsumerState<GradientTextField> {
  late FocusNode _focusNode;
  late bool _isFocused;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode;
    _isFocused = false;

    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    if (_focusNode != widget.focusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: CustomBackgroundGradients.textFieldGradient(context, ref),
      ),
      child: TextField(
        cursorColor: theme.popupcontainertextcolor,
        style: TextStyle(
          color: _isFocused
              ? theme.whitewhiteblack
              : colorscheme == FlexScheme.blackWhite
                  ? Theme.of(context).colorScheme.onSecondary
                  : theme.themeTextColor,
        ),
        controller: widget.controller,
        focusNode: _focusNode,
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(widget.reqNode);
        },
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(
            color: _isFocused
                ? theme.whitewhiteblack
                : colorscheme == FlexScheme.blackWhite
                    ? Theme.of(context).colorScheme.onSecondary
                    : theme.themeTextColor,
          ),
          labelText: widget.hintText,
          labelStyle: TextStyle(color: theme.themeTextColor, fontSize: 14),
          filled: true,
          fillColor:
              _isFocused ? theme.gradienttextfillcolor : Colors.transparent,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent)),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String timeString;

  const NotificationWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.timeString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF9b9b9c),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black87,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Text(
            timeString,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black45,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
