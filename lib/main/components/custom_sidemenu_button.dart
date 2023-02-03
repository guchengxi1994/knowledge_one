import 'package:flutter/material.dart';
import 'package:knowledge_one/common/app_style.dart';
import 'package:knowledge_one/main/providers/page_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSidemenuButton extends StatelessWidget {
  const CustomSidemenuButton(
      {Key? key,
      required this.iconUrl,
      required this.title,
      required this.buttonId,
      this.isSvg = false})
      : super(key: key);
  final String iconUrl;
  final String title;
  final int buttonId;
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    final bool isSelected =
        context.watch<PageChangeController>().currentPageIndex == buttonId;

    return context.select<PageChangeController, bool>(
      (value) => value.collapse,
    )
        ? Container(
            width: AppStyle.sideMenuWidthCollapse - 20,
            height: 38,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              onTap: () {
                context.read<PageChangeController>().changeIndex(buttonId);
              },
              child: Tooltip(
                // verticalOffset: -13,
                // margin:
                //     EdgeInsets.only(left: AppStyle.sideMenuWidthCollapse - 15),
                message: title,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: !isSvg
                      ? Image.asset(
                          iconUrl,
                          width: 16,
                          height: 16,
                        )
                      : SizedBox(
                          width: 16,
                          height: 16,
                          child: SvgPicture.asset(
                            iconUrl,
                            color: isSelected
                                ? const Color.fromARGB(255, 40, 40, 255)
                                : const Color.fromARGB(255, 88, 88, 88),
                            width: 16,
                            height: 16,
                          ),
                        ),
                ),
              ),
            ),
          )
        : Container(
            width: AppStyle.sideMenuWidth - 20,
            height: 38,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              onTap: () {
                context.read<PageChangeController>().changeIndex(buttonId);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !isSvg
                        ? Image.asset(
                            iconUrl,
                            width: 16,
                            height: 16,
                          )
                        : SizedBox(
                            width: 16,
                            height: 16,
                            child: SvgPicture.asset(
                              iconUrl,
                              color: isSelected
                                  ? const Color.fromARGB(255, 40, 40, 255)
                                  : const Color.fromARGB(255, 88, 88, 88),
                              width: 16,
                              height: 16,
                            ),
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Text(
                      title,
                      maxLines: null,
                      softWrap: true,
                      style: isSelected
                          ? AppStyle.sidebarSelectedTextStyle
                          : AppStyle.sidebarUnSelectedTextStyle,
                    ))
                  ],
                ),
              ),
            ),
          );
  }
}
