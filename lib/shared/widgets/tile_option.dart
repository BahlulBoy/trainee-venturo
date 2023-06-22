import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';

class TileOption extends StatelessWidget {
  final String? icon;
  final String title;
  final String message;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? messageStyle;
  final TextStyle? messageSubtitleStyle;
  final void Function()? onTap;
  final double? iconSize;

  const TileOption(
      {super.key,
      this.icon,
      required this.title,
      required this.message,
      this.titleStyle,
      this.subtitleStyle,
      this.messageStyle,
      this.messageSubtitleStyle,
      this.onTap,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) => icon == null,
                      widgetBuilder: (context) => 5.horizontalSpaceRadius,
                      fallbackBuilder: (context) => Container(
                        constraints:
                            BoxConstraints(minWidth: (iconSize ?? 20.r) * 2),
                        child: SvgPicture.asset(
                          icon!,
                          height: iconSize ?? 20.r,
                          width: iconSize ?? 20.r,
                        ),
                      ),
                    ),

                    /// Text Title
                    Text(
                      title,
                      style: titleStyle ?? Get.textTheme.titleSmall,
                    ),
                    10.horizontalSpaceRadius,
                  ],
                ),
              ),

              /// Text Messages
              Text(
                message,
                style: messageStyle ?? Get.textTheme.bodyMedium,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),

              /// Icon right chevron
              const Icon(
                Icons.chevron_right,
                color: MainColor.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
