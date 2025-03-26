import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:hously_flutter/theme/apptheme.dart';

const kGoogleApiKey = "AIzaSyCZoZc4bB4xSJRkctpmwZaCtgQ-OFUjwnE";

class AddLocationWidget extends ConsumerWidget {
  AddLocationWidget({super.key});

  // final _yourProxyURL = 'https://your-proxy.com/';
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return GooglePlacesAutoCompleteTextFormField(
      textEditingController: _textController,
      style: TextStyle(color: theme.textFieldColor),
      googleAPIKey: kGoogleApiKey,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: theme.textFieldColor),
        border: UnderlineInputBorder(),
        hintText: 'Add location',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      // proxyURL: _yourProxyURL,
      maxLines: 1,
      overlayContainerBuilder: (child) => Material(
        elevation: 1.0,
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
      onSuggestionClicked: (prediction) => _textController.text = prediction.description!,
    );
  }
}
