import 'package:eye_rex_us/themes/app_colors.dart';
import 'package:eye_rex_us/themes/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart' as fonts;

class AppText {
  final String text; // Ensure text is a String
  final BuildContext context;
  final Color? color;
  final double? fontSize;
  final bool? underLine;
  final bool? italic; // Added italic property
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final String? fontFamily;
  final double? height;

  AppText(
      this.text,
      this.context, {
        this.color,
        this.underLine,
        this.italic, // Added italic parameter
        this.fontSize,
        this.fontWeight,
        this.overflow,
        this.textAlign,
        this.maxLines,
        this.fontFamily,
        this.height,
      });

  Widget _buildText(
      String text, {
        required double fontSize,
        required Color color,
        FontWeight? weight,
        TextOverflow? overflow,
        TextAlign? textAlign,
        bool underline = false,
        bool italic = false, // Added italic parameter
        String? fontFamily,
        double? height, // Add height parameter here
        int? maxLines,  // Add maxLines parameter here
      }) =>
      Text(
        text,
        style: fonts.GoogleFonts.getFont(
          fontFamily ?? "Poppins",
          fontSize: fontSize.sp,
          color: color,
          fontWeight: weight,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal, // Added fontStyle
          decorationColor: color,
          decoration: underline ? TextDecoration.underline : TextDecoration.none,
          height: height, // Set height
        ),
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines, // Set maxLines
      );

  Widget get heading1 => _buildText(
    text,
    fontSize: fontSize ?? 40.sp,
    color: color ?? context.colorScheme.appHeadingColor,
    weight: fontWeight ?? FontWeight.w900,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
    height: height,
    italic: italic ?? false,
  );
  Widget get heading2 => _buildText(
    text,
    fontSize: fontSize ?? 32.sp,
    color: color ?? context.colorScheme.appHeadingColor,
    weight: fontWeight ?? FontWeight.w900,
    overflow: overflow,
    textAlign: textAlign,
    fontFamily: fontFamily,
    maxLines: maxLines,
    height: height,
    italic: italic ?? false,
  );
  Widget get heading => _buildText(
    text,
    fontSize: fontSize ?? 28.sp,
    color: color ?? context.colorScheme.appHeadingColor,
    weight: fontWeight ?? FontWeight.w600,
    overflow: overflow,
    textAlign: textAlign,
    fontFamily: fontFamily,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );

  Widget get heading3 => _buildText(
    text,
    fontSize: fontSize ?? 24.sp,
    color: color ?? context.colorScheme.appHeadingColor,
    weight: fontWeight ?? FontWeight.w500,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );

  Widget get heading4 => _buildText(
    text,
    fontSize: fontSize ?? 20.sp,
    color: color ?? context.colorScheme.appHeadingColor,
    weight: fontWeight ?? FontWeight.w500,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );

  Widget get heading5 => _buildText(
    text,
    fontSize: fontSize ?? 18.sp,
    color: color ?? context.colorScheme.appHeadingColor,
    weight: fontWeight ?? FontWeight.w500,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );

  Widget get heading6 => _buildText(
    text,
    fontSize: fontSize ?? 16.sp,
    color: color ?? context.colorScheme.appHeadingColor,
    weight: FontWeight.bold,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );

  Widget get bodyXLarge => _buildText(
    text,
    fontSize: fontSize ?? 18.sp,
    color: color ?? context.colorScheme.appBodyColor,
    weight: fontWeight ?? FontWeight.w600,
    overflow: overflow,
    textAlign: textAlign,
    fontFamily: fontFamily,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );

  Widget get bodyLarge => _buildText(
    text,
    fontSize: fontSize ?? 16.sp,
    color: color ?? context.colorScheme.appBodyColor,
    weight: fontWeight ?? FontWeight.w600,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );

  Widget get bodyMedium => _buildText(
    text,
    fontSize: fontSize ?? 13.sp,
    color: color ?? context.colorScheme.appBodyColor,
    weight: fontWeight ?? FontWeight.w600,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );

  Widget get bodySmall => _buildText(
    text,
    fontSize: fontSize ?? 11.sp,
    color: color ?? context.colorScheme.appBodyColor,
    weight: fontWeight ?? FontWeight.w600,
    overflow: overflow,
    textAlign: textAlign,
    fontFamily: fontFamily,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );

  Widget get bodyXSmall => _buildText(
    text,
    fontSize: fontSize ?? 10.sp,
    color: color ?? context.colorScheme.appBodyColor,
    weight: fontWeight ?? FontWeight.w600,
    overflow: overflow,
    textAlign: textAlign,
    fontFamily: fontFamily,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );

  Widget get bodyVerySmall => _buildText(
    text,
    fontSize: fontSize ?? 10.sp,
    color: color ?? context.colorScheme.appBodyColor,
    weight: fontWeight ?? FontWeight.w600,
    overflow: overflow,
    textAlign: textAlign,
    maxLines: maxLines,
    height: height,
    underline: underLine ?? false,
    italic: italic ?? false,
  );
}