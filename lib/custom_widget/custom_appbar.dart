import 'dart:ui';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool centerTitle;
  final VoidCallback? onTitleTap;

  final bool showPrefix;
  final Widget? prefix;
  final VoidCallback? onPrefixTap;

  final bool showSuffix;
  final Widget? suffix;
  final VoidCallback? onSuffixTap;

  final double height;
  final Color? backgroundColor;
  final Gradient? gradient;

  final bool enableBlur;
  final double blurSigma;

  const CustomAppbar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.onTitleTap,
    this.showPrefix = false,
    this.prefix,
    this.onPrefixTap,
    this.showSuffix = false,
    this.suffix,
    this.onSuffixTap,
    this.height = kToolbarHeight,
    this.backgroundColor,
    this.gradient,
    this.enableBlur = false,
    this.blurSigma = 10,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final appBarTheme = theme.appBarTheme;

    // ✅ Background color logic (priority based)
    final bgColor = gradient == null
        ? backgroundColor ??
        appBarTheme.foregroundColor ??
        colors.primaryContainer
        : null;

    Widget bar = Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        gradient: gradient,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // 🔹 PREFIX
            if (showPrefix)
              SizedBox(
                width: 48,
                child: GestureDetector(
                  onTap: onPrefixTap,
                  behavior: HitTestBehavior.opaque,
                  child: prefix ?? const SizedBox(),
                ),
              ),

            // 🔹 TITLE
            Expanded(
              child: GestureDetector(
                onTap: onTitleTap,
                behavior: HitTestBehavior.opaque,
                child: Align(
                  alignment:
                  centerTitle ? Alignment.center : Alignment.centerLeft,
                  child: title ?? const SizedBox(),
                ),
              ),
            ),

            // 🔹 SUFFIX
            if (showSuffix)
              SizedBox(
                width: 48,
                child: GestureDetector(
                  onTap: onSuffixTap,
                  behavior: HitTestBehavior.opaque,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: suffix ?? const SizedBox(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    // 🔮 Blur
    if (enableBlur) {
      bar = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: bar,
        ),
      );
    }

    return bar;
  }
}