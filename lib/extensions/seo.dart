import 'package:flutter/material.dart';

import '../seo/head_tag.dart';
import '../seo/seo.dart';

extension SeoExtension on Widget {
  Widget seoParagraph(String text, [TextTagStyle style = TextTagStyle.p]) {
    return Seo.text(text: text, style: style, child: this);
  }

  Widget seoHeadline1(String text) {
    return Seo.text(text: text, style: TextTagStyle.h1, child: this);
  }

  Widget seoHeadline2(String text) {
    return Seo.text(text: text, style: TextTagStyle.h2, child: this);
  }

  Widget seoController(BuildContext context) {
    return SeoController(
        enabled: true, tree: WidgetTree(context: context), child: this);
  }

  Widget seoHeadline3(String text) {
    return Seo.text(text: text, style: TextTagStyle.h3, child: this);
  }

// <a href='www.google.com' style="text-decoration:none"><p style="color:transparent">change link color</p></a>
  Widget seoLink(String url) {
    return Seo.link(
      href: url,
      anchor: url,
      child: this,
    );
  }

  Widget seoImage(String url, String alt) {
    return Seo.image(src: url, alt: alt, child: this);
  }

  Widget seoHead(List<HeadTag> tags) {
    return Seo.head(tags: tags, child: this);
  }
}
