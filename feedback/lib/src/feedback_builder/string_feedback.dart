import 'package:feedback/src/better_feedback.dart';
import 'package:feedback/src/l18n/translation.dart';
import 'package:feedback/src/theme/feedback_theme.dart';
import 'package:flutter/material.dart';

/// Prompt the user for feedback using `StringFeedback`.
Widget simpleFeedbackBuilder(
  BuildContext context,
  OnSubmit onSubmit,
  ScrollController? scrollController,
) =>
    StringFeedback(onSubmit: onSubmit, scrollController: scrollController);

/// A form that prompts the user for feedback with a single text field.
/// This is the default feedback widget used by [BetterFeedback].
class StringFeedback extends StatefulWidget {
  /// Create a [StringFeedback].
  /// This is the default feedback bottom sheet, which is presented to the user.
  const StringFeedback({
    super.key,
    required this.onSubmit,
    required this.scrollController,
  });

  /// Should be called when the user taps the submit button.
  final OnSubmit onSubmit;

  /// A scroll controller that expands the sheet when it's attached to a
  /// scrollable widget and that widget is scrolled.
  ///
  /// Non null if the sheet is draggable.
  /// See: [FeedbackThemeData.sheetIsDraggable].
  final ScrollController? scrollController;

  @override
  State<StringFeedback> createState() => _StringFeedbackState();
}

class _StringFeedbackState extends State<StringFeedback> {
  late TextEditingController controller;
  late TextEditingController descriptionController;
  String? selectedDropdownValue; // State for the dropdown's selected value.

  final List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem(value: 'Younis', child: Text('Younis')),
    const DropdownMenuItem(value: 'Abbas', child: Text('Abbas')),
    const DropdownMenuItem(value: 'Alexander', child: Text('Alexander')),
  ];

  @override
  void dispose() {
    controller.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ListView(
                controller: widget.scrollController,
                // Pad the top by 20 to match the corner radius if drag enabled.
                padding: EdgeInsets.fromLTRB(
                    16, widget.scrollController != null ? 20 : 16, 16, 0),
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    child: DropdownButton<String>(
                      value: selectedDropdownValue,
                      items: items,
                      hint: Text(FeedbackLocalizations.of(context)
                          .feedbackDescriptionText),
                      onChanged: (value) {
                        setState(() {
                          selectedDropdownValue = value;
                        });
                        debugPrint('Selected: $value');
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.white70), // Hint text color (optional)
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Border color (optional)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Border color when focused
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    key: const Key('text_input_field'),
                    maxLines: 1,
                    minLines: 1,
                    controller: controller,
                    textInputAction: TextInputAction.done,
                    onChanged: (_) {
                      //print(_);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.white70), // Hint text color (optional)
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Border color (optional)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Border color when focused
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    key: const Key('description_text_input_field'),
                    maxLines: 3,
                    minLines: 1,
                    controller: descriptionController,
                    textInputAction: TextInputAction.done,
                    onChanged: (_) {
                      //print(_);
                    },
                  ),
                ],
              ),
              if (widget.scrollController != null)
                const FeedbackSheetDragHandle(),
            ],
          ),
        ),
        TextButton(
          key: const Key('submit_feedback_button'),
          child: Text(
            FeedbackLocalizations.of(context).submitButtonText,
            style: TextStyle(
              color: FeedbackTheme.of(context).activeFeedbackModeColor,
            ),
          ),
          onPressed: () => widget.onSubmit(controller.text),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
