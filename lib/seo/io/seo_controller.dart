import 'package:flutter/material.dart';
import 'package:hously_flutter/seo/src/seo_tree.dart';

class SeoController extends StatelessWidget {
  final Widget child;

  const SeoController({
    super.key,
    bool enabled = false,
    required SeoTree tree,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => child;
}
