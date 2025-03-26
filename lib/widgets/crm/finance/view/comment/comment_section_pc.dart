import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:intl/intl.dart'; // Dodaj import do intl
import 'dart:convert'; // Dodaj import dla utf8.decode



class CommentSectionPc extends ConsumerStatefulWidget {
  final int id;

  const CommentSectionPc({
    super.key,
    required this.id,
  });

  @override
  _CommentSectionPcState createState() => _CommentSectionPcState();
}

class _CommentSectionPcState extends ConsumerState<CommentSectionPc> {
  List<dynamic> _comments = [];

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      final response = await ApiServices.get(
        ref:ref,
        URLs.commentsByUserContacts('${widget.id}'),
        hasToken: true,
      );


    if (response != null && response.statusCode == 200) {
      final decodedBody = utf8.decode(response.data); // Dekodowanie UTF-8
      final jsonData = jsonDecode(decodedBody); // Parsowanie JSON-a

      setState(() {
        _comments = jsonData is List ? jsonData : []; // Ustawienie danych
      });
      } else {
        final snackBar = Customsnackbar().showSnackBar(
            "Error", 'Błąd podczas pobierania komentarzy.'.tr, "error", () {
          _fetchComments();
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = Customsnackbar().showSnackBar(
          "Error", 'Błąd podczas pobierania komentarzy:$e'.tr, "error", () {
        _fetchComments();
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _editComment(int commentId, String newComment) async {
    try {
      final response = await ApiServices.put(
        URLs.userContactsCommentDetails('$commentId'),
        hasToken: true,
        data: {'content': newComment},
      );

      if (response != null && response.statusCode == 200) {
        final snackBar = Customsnackbar().showSnackBar(
          "success",
          'Komentarz zaktualizowany pomyślnie!'.tr,
          "success",
          () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _fetchComments(); // Refresh comments
      } else {
        final errorSnackBar = Customsnackbar().showSnackBar(
          "Error",
          'Błąd podczas edytowania komentarza.'.tr,
          "error",
          () {
            _fetchComments();
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    } catch (e) {
      final errorSnackBar = Customsnackbar().showSnackBar(
        "Error",
        'Błąd podczas edytowania komentarza: $e'.tr,
        "error",
        () {
          _fetchComments();
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
  }

  Future<void> _deleteComment(int commentId) async {
    try {
      final response = await ApiServices.delete(
        URLs.userContactsCommentDetails('$commentId'),
        hasToken: true,
      );

      if (response != null && response.statusCode == 204) {
        final successSnackBar = Customsnackbar().showSnackBar(
          "success",
          'Komentarz usunięty pomyślnie!'.tr,
          "success",
          () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
        _fetchComments(); // Refresh comments
      } else {
        final errorSnackBar = Customsnackbar().showSnackBar(
          "Error",
          'Błąd podczas usuwania komentarza.'.tr,
          "error",
          () {
            _fetchComments();
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    } catch (e) {
      final errorSnackBar = Customsnackbar().showSnackBar(
        "Error",
        'Błąd podczas usuwania komentarza: $e'.tr,
        "error",
        () {
          _fetchComments();
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
  }

  String _formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 1920 * 180;
    itemWidth = max(120.0, min(itemWidth, 180.0));
    double minBaseTextSize = 12;
    double maxBaseTextSize = 16;
    double dynamicFontSize = minBaseTextSize +
        (itemWidth - 120) / (180 - 120) * (maxBaseTextSize - minBaseTextSize);
    dynamicFontSize =
        max(minBaseTextSize, min(dynamicFontSize, maxBaseTextSize));

    return Column(
      children: [
        const SizedBox(height: 10),
        AddCommentForm(clientId: widget.id, onCommentAdded: _fetchComments),
        const SizedBox(height: 10),
        ..._comments.map((comment) => ListTile(
              title:
                  Text(comment['content'], style: AppTextStyles.interLight16),
              subtitle: Text(_formatDate(comment['created_at']),
                  style: AppTextStyles.interLight10),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      AppIcons.pencil,
                      color: AppColors.light,
                    ),
                    onPressed: () async {
                      String? newComment = await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          final _editController =
                              TextEditingController(text: comment['content']);
                          return AlertDialog(
                            title: Text('Edytuj komentarz'.tr),
                            content: TextField(
                              controller: _editController,
                              decoration: InputDecoration(
                                  hintText: 'Wpisz nowy komentarz'.tr),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Anuluj'.tr),
                                onPressed: () {
                                  ref.read(navigationService).beamPop();
                                },
                              ),
                              TextButton(
                                child: Text('Zapisz'.tr),
                                onPressed: () {
                                  ref
                                      .read(navigationService)
                                      .beamPop(_editController.text);
                                },
                              ),
                            ],
                          );
                        },
                      );

                      if (newComment != null && newComment.isNotEmpty) {
                        _editComment(comment['id'], newComment);
                      }
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(AppIcons.delete, color: AppColors.light),
                    onPressed: () {
                      _deleteComment(comment['id']);
                    },
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class AddCommentForm extends StatelessWidget {
  final int clientId;
  final VoidCallback onCommentAdded;

  AddCommentForm(
      {super.key, required this.clientId, required this.onCommentAdded});

  final _formKeyAddComment = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  Future<void> _submitComment(BuildContext context) async {
    if (_formKeyAddComment.currentState!.validate()) {
      try {
        final response = await ApiServices.post(
          URLs.commentsByUserContacts('$clientId'),
          hasToken: true,
          data: {'content': _commentController.text},
        );

      if (response != null && response.statusCode == 201) {
  final successSnackBar = Customsnackbar().showSnackBar(
    "success", 
    'Komentarz dodany pomyślnie!'.tr, 
    "success", 
    () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    },
  );
  ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
  _commentController.clear();
  onCommentAdded();
} else {
  final errorSnackBar = Customsnackbar().showSnackBar(
    "Error", 
    'Błąd podczas dodawania komentarza.'.tr, 
    "error", 
    () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    },
  );
  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
}

} catch (e) {
  final errorSnackBar = Customsnackbar().showSnackBar(
    "Error", 
    'Błąd podczas dodawania komentarza: $e'.tr, 
    "error", 
    () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    },
  );
  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
}

    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyAddComment,
      child: Column(
        children: [
          TextFormField(
            controller: _commentController,
            decoration: InputDecoration(
                labelText: 'Dodaj komentarz'.tr,
                labelStyle: AppTextStyles.interLight),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Proszę wpisać komentarz'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _submitComment(context),
            child: Text('Dodaj Komentarz'.tr, style: AppTextStyles.interLight),
          ),
        ],
      ),
    );
  }
}
