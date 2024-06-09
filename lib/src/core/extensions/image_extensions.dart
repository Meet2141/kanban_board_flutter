import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// ImageExtension file contains extension for string that
/// return an widget of image with it's file path.
/// E.g. 'user'.getSVGImage, returns SvgPicture.asset(assets/svgs/user.svg);
extension ImageExtension on String {
  String get getSVG => 'assets/svgs/$this.svg';

  /// SVG Image
  Widget getSVGImageHW({double? height, double? width, Color? color, fit = BoxFit.contain}) => SvgPicture.asset(
    getSVG,
    height: height,
    width: width,
    colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    fit: fit,
  );

  String get getPNG => 'assets/images/$this.png';

  /// PNG Image
  Widget getPNGImageHW({double? height, double? width, Color? color, fit = BoxFit.contain}) =>
      Image.asset(getPNG, height: height, width: width, color: color, fit: fit);

  String get getJPG => 'assets/images/$this.jpg';

  /// JPG Image
  Widget getJPGImageHW({double? height, double? width, Color? color, fit = BoxFit.contain}) =>
      Image.asset(getJPG, height: height, width: width, color: color, fit: fit);

  String get getInitial {
    if (isNotEmpty) {
      List strings = split(' ').where((element) => element.isNotEmpty).toList();
      if (strings.length >= 2) {
        return '${strings[0].toString().substring(0, 1)}${strings[1].toString().substring(0, 1)}'.toUpperCase();
      } else {
        return (strings[0].toString().length >= 2 ? strings[0].toString().substring(0, 2) : strings[0].toString())
            .toUpperCase();
      }
    } else {
      return toUpperCase();
    }
  }
}
