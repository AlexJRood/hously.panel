import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/widgets.dart';
import 'package:hously_flutter/theme/design/design.dart';

class AppIcons {
  static const _path = 'assets/icons/';
  static const double _defaultSize = 24;
  static const Color _defaultColor = AppColors.light; // Add theme to production

  // Helper
  static Widget _icon(String name, {double? width, double? height, Color? color}) {
    return SvgPicture.asset(
      '$_path$name.svg',
      width: width ?? _defaultSize,
      height: height ?? _defaultSize,
      color: color ?? _defaultColor,
    );
  }

  // Funkcja dynamiczna na wszelki wypadek
  static Widget fromName(String name, {double? width, double? height, Color? color}) {
    return _icon(name, width: width, height: height, color: color);
  }

  // Funkcje dla każdej ikony (pełna lista!)

  static Widget appleLogoBlack({double? width, double? height, Color? color}) => _icon('apple_logo_black_2', width: width, height: height, color: color);
  static Widget archive({double? width, double? height, Color? color}) => _icon('archive', width: width, height: height, color: color);
  static Widget arrowDown({double? width, double? height, Color? color}) => _icon('arrow_down', width: width, height: height, color: color);
  static Widget arrowUp({double? width, double? height, Color? color}) => _icon('arrow_up', width: width, height: height, color: color);
  static Widget arrowOut({double? width, double? height, Color? color}) => _icon('arrows_out_simple', width: width, height: height, color: color);
  static Widget calendar({double? width, double? height, Color? color}) => _icon('calendar', width: width, height: height, color: color);
  static Widget chat({double? width, double? height, Color? color}) => _icon('chat', width: width, height: height, color: color);
  static Widget chat2({double? width, double? height, Color? color}) => _icon('chat2', width: width, height: height, color: color);
  static Widget checkBox({double? width, double? height, Color? color}) => _icon('checkbox', width: width, height: height, color: color);
  static Widget iosArrowDown({double? width, double? height, Color? color}) => _icon('chevron_down', width: width, height: height, color: color);
  static Widget iosArrowUp({double? width, double? height, Color? color}) => _icon('chevron_up', width: width, height: height, color: color);
  static Widget iosArrowLeft({double? width, double? height, Color? color}) => _icon('chevron_left', width: width, height: height, color: color);
  static Widget iosArrowRight({double? width, double? height, Color? color}) => _icon('chevron_right', width: width, height: height, color: color);
  static Widget close({double? width, double? height, Color? color}) => _icon('close', width: width, height: height, color: color);
  static Widget copySimple({double? width, double? height, Color? color}) => _icon('copy_simple', width: width, height: height, color: color);
  static Widget creditCard({double? width, double? height, Color? color}) => _icon('credit_card', width: width, height: height, color: color);
  static Widget document({double? width, double? height, Color? color}) => _icon('document', width: width, height: height, color: color);
  static Widget dotsSixVertical({double? width, double? height, Color? color}) => _icon('dots_six_vertical', width: width, height: height, color: color);
  static Widget duplicate({double? width, double? height, Color? color}) => _icon('dublicate', width: width, height: height, color: color);
  static Widget faceBookLogo({double? width, double? height, Color? color}) => _icon('facebook', width: width, height: height, color: color);
  static Widget folder({double? width, double? height, Color? color}) => _icon('folder', width: width, height: height, color: color);
  static Widget menu({double? width, double? height, Color? color}) => _icon('frame', width: width, height: height, color: color);
  static Widget sort({double? width, double? height, Color? color}) => _icon('frame_(1)', width: width, height: height, color: color);
  static Widget expand({double? width, double? height, Color? color}) => _icon('frame_(2)', width: width, height: height, color: color);
  static Widget simpleArrowBack({double? width, double? height, Color? color}) => _icon('arrow_back', width: width, height: height, color: color);
  static Widget simpleArrowForward({double? width, double? height, Color? color}) => _icon('arrow_forward', width: width, height: height, color: color);
  static Widget arrowTrendUp({double? width, double? height, Color? color}) => _icon('trending_up', width: width, height: height, color: color);
  static Widget arrowTrendDown({double? width, double? height, Color? color}) => _icon('trending_down', width: width, height: height, color: color);
  static Widget swapVert({double? width, double? height, Color? color}) => _icon('swap', width: width, height: height, color: color);
  static Widget decrease({double? width, double? height, Color? color}) => _icon('remove', width: width, height: height, color: color);
  static Widget arrowBack({double? width, double? height, Color? color}) => _icon('arrow_back_2', width: width, height: height, color: color);
  static Widget check({double? width, double? height, Color? color}) => _icon('check', width: width, height: height, color: color);
  static Widget moreVertical({double? width, double? height, Color? color}) => _icon('more_vertical', width: width, height: height, color: color);
  static Widget viewList({double? width, double? height, Color? color}) => _icon('view_list', width: width, height: height, color: color);
  static Widget refresh({double? width, double? height, Color? color}) => _icon('sync', width: width, height: height, color: color);
  static Widget send({double? width, double? height, Color? color}) => _icon('send_message', width: width, height: height, color: color);
  static Widget disLike({double? width, double? height, Color? color}) => _icon('dislike', width: width, height: height, color: color);
  static Widget like({double? width, double? height, Color? color}) => _icon('like', width: width, height: height, color: color);
  static Widget copy({double? width, double? height, Color? color}) => _icon('copy', width: width, height: height, color: color);
  static Widget pencil({double? width, double? height, Color? color}) => _icon('edit', width: width, height: height, color: color);
  static Widget delete({double? width, double? height, Color? color}) => _icon('delete_2', width: width, height: height, color: color);
  static Widget magic({double? width, double? height, Color? color}) => _icon('magic', width: width, height: height, color: color);
  static Widget visible({double? width, double? height, Color? color}) => _icon('visible', width: width, height: height, color: color);
  static Widget unVisible({double? width, double? height, Color? color}) => _icon('un_visible', width: width, height: height, color: color);
  static Widget location({double? width, double? height, Color? color}) => _icon('location', width: width, height: height, color: color);
  static Widget key({double? width, double? height, Color? color}) => _icon('key', width: width, height: height, color: color);
  static Widget call({double? width, double? height, Color? color}) => _icon('phone_outline', width: width, height: height, color: color);
  static Widget moon({double? width, double? height, Color? color}) => _icon('moon', width: width, height: height, color: color);
  static Widget sun({double? width, double? height, Color? color}) => _icon('sun', width: width, height: height, color: color);
  static Widget monitor({double? width, double? height, Color? color}) => _icon('monitor', width: width, height: height, color: color);
  static Widget notification({double? width, double? height, Color? color}) => _icon('frame_(31)', width: width, height: height, color: color);
  static Widget lowSound({double? width, double? height, Color? color}) => _icon('frame_(32)', width: width, height: height, color: color);
  static Widget silent({double? width, double? height, Color? color}) => _icon('frame_(33)', width: width, height: height, color: color);
  static Widget eyeDropper({double? width, double? height, Color? color}) => _icon('frame_(34)', width: width, height: height, color: color);
  static Widget filterAlt({double? width, double? height, Color? color}) => _icon('frame_(35)', width: width, height: height, color: color);
  static Widget hand({double? width, double? height, Color? color}) => _icon('frame_(36)', width: width, height: height, color: color);
  static Widget circleMinus({double? width, double? height, Color? color}) => _icon('frame_(37)', width: width, height: height, color: color);
  static Widget circlePlus({double? width, double? height, Color? color}) => _icon('frame_(38)', width: width, height: height, color: color);
  static Widget circleQuestion({double? width, double? height, Color? color}) => _icon('frame_(39)', width: width, height: height, color: color);
  static Widget verifiedUser({double? width, double? height, Color? color}) => _icon('frame_(40)', width: width, height: height, color: color);
  static Widget warningAmber({double? width, double? height, Color? color}) => _icon('frame_(41)', width: width, height: height, color: color);
  static Widget camera({double? width, double? height, Color? color}) => _icon('frame_(42)', width: width, height: height, color: color);
  static Widget circleCloseOutlined({double? width, double? height, Color? color}) => _icon('frame_(43)', width: width, height: height, color: color);
  static Widget circleClose({double? width, double? height, Color? color}) => _icon('frame_(44)', width: width, height: height, color: color);
  static Widget circleCloseWhite({double? width, double? height, Color? color}) => _icon('frame_(45)', width: width, height: height, color: color);
  static Widget lockOutline({double? width, double? height, Color? color}) => _icon('frame_(46)', width: width, height: height, color: color);
  static Widget star({double? width, double? height, Color? color}) => _icon('frame_(47)', width: width, height: height, color: color);
  static Widget gridView({double? width, double? height, Color? color}) => _icon('grid_view', width: width, height: height, color: color);
  static Widget straighten({double? width, double? height, Color? color}) => _icon('frame_(49)', width: width, height: height, color: color);
  static Widget circularDollar({double? width, double? height, Color? color}) => _icon('frame_(50)', width: width, height: height, color: color);
  static Widget person({double? width, double? height, Color? color}) => _icon('frame_(51)', width: width, height: height, color: color);
  static Widget mapView({double? width, double? height, Color? color}) => _icon('map_view', width: width, height: height, color: color);
  static Widget global({double? width, double? height, Color? color}) => _icon('frame_(53)', width: width, height: height, color: color);
  static Widget setting({double? width, double? height, Color? color}) => _icon('frame_(54)', width: width, height: height, color: color);
  static Widget clock({double? width, double? height, Color? color}) => _icon('frame_(55)', width: width, height: height, color: color);
  static Widget share({double? width, double? height, Color? color}) => _icon('frame_(56)', width: width, height: height, color: color);
  static Widget download({double? width, double? height, Color? color}) => _icon('frame_(57)', width: width, height: height, color: color);
  static Widget printer({double? width, double? height, Color? color}) => _icon('frame_(58)', width: width, height: height, color: color);
  static Widget pause({double? width, double? height, Color? color}) => _icon('frame_(59)', width: width, height: height, color: color);
  static Widget googleLogo({double? width, double? height, Color? color}) => _icon('google', width: width, height: height, color: color);
  static Widget heart({double? width, double? height, Color? color}) => _icon('heart', width: width, height: height, color: color);
  static Widget home({double? width, double? height, Color? color}) => _icon('home', width: width, height: height, color: color);
  static Widget homeModern({double? width, double? height, Color? color}) => _icon('home_modern', width: width, height: height, color: color);
  static Widget bed({double? width, double? height, Color? color}) => _icon('bed', width: width, height: height, color: color);
  static Widget bathroom({double? width, double? height, Color? color}) => _icon('bathroom', width: width, height: height, color: color);
  static Widget instagramLogo({double? width, double? height, Color? color}) => _icon('instagram_logo', width: width, height: height, color: color);
  static Widget message({double? width, double? height, Color? color}) => _icon('mesage', width: width, height: height, color: color);
  static Widget email({double? width, double? height, Color? color}) => _icon('email', width: width, height: height, color: color);
  static Widget newChat({double? width, double? height, Color? color}) => _icon('new_chat', width: width, height: height, color: color);
  static Widget openAiLogo({double? width, double? height, Color? color}) => _icon('open_ai_logo', width: width, height: height, color: color);
  static Widget paperClip({double? width, double? height, Color? color}) => _icon('paper_clip', width: width, height: height, color: color);
  static Widget pie({double? width, double? height, Color? color}) => _icon('pie', width: width, height: height, color: color);
  static Widget add({double? width, double? height, Color? color}) => _icon('add', width: width, height: height, color: color);
  static Widget qrCode({double? width, double? height, Color? color}) => _icon('qr_code', width: width, height: height, color: color);
  static Widget search({double? width, double? height, Color? color}) => _icon('search', width: width, height: height, color: color);
  static Widget sendAbove({double? width, double? height, Color? color}) => _icon('send', width: width, height: height, color: color);
  static Widget task({double? width, double? height, Color? color}) => _icon('task', width: width, height: height, color: color);
  static Widget telegramLogo({double? width, double? height, Color? color}) => _icon('telegram_logo', width: width, height: height, color: color);
  static Widget youtubeLogo({double? width, double? height, Color? color}) => _icon('youtube_logo', width: width, height: height, color: color);
}
