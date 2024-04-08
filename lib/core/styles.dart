import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  /// App Settings

  //Color
  static Color get colorPrimary => Color(0xFF488B89);

  static Color get colorSecondry => Color(0xFFDD623A);

  static Color get colorBackground => Color(0xFFF3F6F6);

  static Color get colorBackgroundNavBar => Color(0xFFFFFFFF);

  static Color get colorBackgroundAppBar => Color(0xFFFFFFFF);

  static Color get colorGradientStart => Color(0xFF488B89);

  static Color get colorGradientEnd => Color(0xFF7BB5B3);

  static Color get colorTextInactive => Color(0xFF828282);

  static Color get colorAppBarProfile => Color(0xFFFCF0EC);

  static Color get colorCardBackground => Color(0xFFFFFFFF);

  static Color get colorSelectedLanguage => Color(0xFFFFE3DA);

  static Color get colorSelectedTab => Color(0xFFFFE3DA);

  static Color get colorNoImageBackground => Color(0xFFFFE3DA);

  static Color get colorBackArrowIcon => Color(0xFF333333);

  static Color get colorBtnMapBackground => Color(0xFFEDF4F4);

  static Color get colorBackgourndWaitingNotication => Color(0xFFFCF4DB);

  static Color get colorBackgourndReview => Color(0xFFFCF4DB);

  static Color get colorBtnSendBackground => Color(0xFFEDF4F4);

  static Color get colorBtnTrashBackground => Color(0xFFEDF4F4);

  static Color get colorTextTitle => Color(0xFF333333);

  static Color get colorTextDialogDangerTitle => Color(0xFFF2994A);

  static Color get colorTextTextField => Color(0xFF4F4F4F);

  static Color get colorBackgroundContanier => Color(0xFFFFFFFF);

  static Color get colorBorderTextField => Color(0xFFE0E0E0);

  static Color get colorTextWhite => Color(0xFFFFFFFF);

  static Color get colorTextError => Color(0xFFEB5757);

  static Color get colorCancelBackground => Color(0xFFF2F2F2);

  static Color get colorReviewInActiveBackground => Color(0xFFF2F2F2);

  static Color get colorTextOngoing => Color(0xFFF2C94C);

  static Color get colorRateStar => Color(0xFFF2C94C);

  static Color get colorTextFinsihed => Color(0xFF27AE60);

  static Color get colorWhatsApp => Color(0xFF29A71A);

  static Color get colorWhatsAppBackground => Color(0xFFDFEFE1);

  static Color get colorNotificationIcon => Color(0xFF292D32);

  static Color get colorTextMissied => Color(0xFFEB5757);

  static Color get colorFavouriteIcon => Color(0xFFEB5757);

  static Color get colorAudioAttachmentBackground => Color(0xFFF2F2F2);

  static Color get colorRecievedAttachmentBackground => Color(0xFFD4EFDF);

  static Color get colorAttachmentBloodTestBackgournd => Color(0xFFFBDDDD);

  static Color get colorInstructionContainerBackgournd => Color(0xFFFBDDDD);

  static Color get colorHelperTextBackgournd => Color(0xFFFFEDDD);

  static Color get colorIconSVGCoin => Color(0xFFBDBDBD);

  static Color get colorIconArrowCheckBoxList => Color(0xFFBDBDBD);

  /// font
  static const FontFamily = 'Alexandria';
  static const FontFamilyBlack = 'Alexandria';
  static const FontFamilyBold = 'Alexandria';
  static const FontFamilySemiBold = 'Alexandria';
  static const FontFamilyLight = 'Alexandria';
  static const FontFamilyMedium = 'Alexandria';
  static const FontFamilyRegular = 'Alexandria';

  /// font
  // static const FontFamilyArb = 'ArbFONTS';
  // static const FontFamilyBoldArb = 'ArbFONTS';
  // static const FontFamilyLightArb = 'ArbFONTS';
  // static const FontFamilyRegularArb = 'ArbFONTS';
  static const FontFamilyArb = 'SarmadyVF';
  static const FontFamilyBoldArb = 'SarmadyVF';
  static const FontFamilyLightArb = 'SarmadyVF';
  static const FontFamilyRegularArb = 'SarmadyVF';

  static double fontSizeCustom(double size) => size;

  static TextStyle get fontStyle => TextStyle(fontFamily: FontFamily);

  static TextStyle get fontW500Style => TextStyle(
        fontFamily: FontFamily,
      );

  static TextStyle get fontW300Style => TextStyle(
        fontFamily: FontFamily,
      );

  static StrutStyle get structStyle => StrutStyle(fontFamily: FontFamily);

  static BoxDecoration tilesDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10.r),
      ),
      border: Border.all(color: Color(0xFFAFCEEB).withOpacity(0.09)),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          spreadRadius: 0,
          offset: Offset(0, 5), // changes position of shadow
        )
      ],
      color: Colors.white);

  static TextStyle w700TextStyle() => fontStyle.copyWith(
      fontSize: 10.sp,
      fontWeight: FontWeight.w700,
      height: 1.2,
      overflow: TextOverflow.fade,
      // fontFamily: !isArb ? FontFamilyBoldArb : Styles.FontFamily,
      fontFamily: FontFamilyBoldArb,
      color: Styles.colorPrimary);

  static TextStyle w400TextStyle() => fontStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamilyRegularArb,
        height: 1.2,
        overflow: TextOverflow.fade,
      );

  static TextStyle w300TextStyle() => fontStyle.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w300,
        height: 1.2,
        overflow: TextOverflow.fade,
        fontFamily: FontFamilyLightArb,
      );

  static TextStyle w600TextStyle() => fontStyle.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
        overflow: TextOverflow.fade,
        fontFamily: FontFamilyBoldArb,
      );

  static TextStyle w500TextStyle() => fontStyle.copyWith(
      fontSize: 10.sp,
      height: 1.2,
      overflow: TextOverflow.fade,
      fontWeight: FontWeight.w500,
      color: Styles.colorPrimary);

  static BoxDecoration roundedDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(5.r),
      ),
      color: colorPrimary);

  static BoxDecoration roundedDecorationWithRaduis({
    double radius = 5,
    Color color = const Color(0xFF488B89),
  }) =>
      BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          color: color);

  static BoxDecoration coloredRoundedDecorationWithRaduis({
    double radius = 5,
    Color borderColor = const Color(0xFF488B89),
    Color color = const Color(0xFFFFFFFF),
  }) =>
      BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          border: Border.all(color: borderColor),
          color: color);

  static TextStyle formInputTextStyle = fontStyle.copyWith(
      fontWeight: FontWeight.w200, fontFamily: Styles.FontFamily);
  static InputDecoration formInputDecoration = InputDecoration(
      border: InputBorder.none, filled: true, fillColor: Colors.white);

  static InputDecoration borderedRoundedFieldDecoration({double radius = 40}) =>
      formInputDecoration.copyWith(
          border: roundedOutlineInputBorder(radius: radius),
          focusedBorder: roundedOutlineInputBorder(radius: radius),
          enabledBorder: roundedOutlineInputBorder(radius: radius),
          errorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedOutlineInputBorder(radius: radius),
          contentPadding: EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white);

  static InputBorder roundedTransparentBorder({double radius = 40}) =>
      OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(radius),
      );

  static InputBorder roundedOutlineInputBorder({double radius = 40}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: Styles.colorPrimary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(radius),
      );
}
