import 'package:flutter/material.dart';
import 'package:hously_flutter/seo/head_tag.dart';
import 'package:hously_flutter/seo/src/seo_tag.dart';

class Seo extends StatelessWidget {
  final Widget child;

  const Seo.text({
    super.key,
    required String text,
    TextTagStyle style = TextTagStyle.p,
    required this.child,
  });

  const Seo.image({
    super.key,
    required String alt,
    required String src,
    required this.child,
  });

  const Seo.link({
    super.key,
    required String anchor,
    required String href,
    required this.child,
  });

  const Seo.head({
    super.key,
    required List<HeadTag> tags,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => child;
}
