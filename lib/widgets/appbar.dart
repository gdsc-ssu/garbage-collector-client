import 'package:garbage_collector/styles/styles.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool allowBackButton;
  final String title;
  final Widget? titleWidget;
  final Color color;

  ///actions는 AppBarButton 내부에서만 사용할 수 있도록 제작
  final List<Widget>? actions;
  final String goingBackString;
  final bool isTitleCentered;

  final void Function()? onTapBack;

  CustomAppBar(
      {Key? key,
      this.allowBackButton = true,
      this.goingBackString = '',
      required this.title,
      this.actions,
      this.onTapBack,
      this.isTitleCentered = true,
      this.titleWidget,
      this.color = ColorSystem.primary})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: (titleWidget == null)
          ? Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
                color: color,
              ),
            )
          : titleWidget,
      centerTitle: isTitleCentered,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      leadingWidth: (goingBackString == '') ? 50 : 70,
      leading: () {
        if (allowBackButton) {
          if (goingBackString != '') {
            return InkWell(
                onTap: onTapBack ??
                    () {
                      Get.back();
                    },
                overlayColor: MaterialStateProperty.all(
                  Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    goingBackString,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ));
          }
          return GestureDetector(
            onTap: onTapBack ?? () => Get.back(),
            behavior: HitTestBehavior.translucent,
            child: const Center(child: Icon(Icons.chevron_left_rounded)),
          );
        }

        return Container();
      }(),
      actions: actions,
    );
  }
}
