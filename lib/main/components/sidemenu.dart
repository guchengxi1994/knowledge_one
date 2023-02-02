import 'package:flutter/material.dart';
import 'package:knowledge_one/common/app_style.dart';
import 'package:provider/provider.dart';

import '../providers/page_controller.dart';
import 'custom_sidemenu_button.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
      width:
          context.select<PageChangeController, bool>((value) => value.collapse)
              ? AppStyle.sideMenuWidthCollapse
              : AppStyle.sideMenuWidth,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: buildFilesButtons()),
          context.select<PageChangeController, bool>((value) => value.collapse)
              ? Center(
                  child: InkWell(
                    onTap: () {
                      context.read<PageChangeController>().changeCollapse();
                    },
                    child: Transform.rotate(
                      angle: 3.14 / 2,
                      child: const Icon(
                        Icons.expand,
                        size: 25,
                      ),
                    ),
                  ),
                )
              : TextButton(
                  onPressed: () {
                    context.read<PageChangeController>().changeCollapse();
                  },
                  child: const Text("收起侧边栏"))
        ],
      ),
    );
  }

  Widget buildFilesButtons() {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CustomSidemenuButton(
            iconUrl: "assets/icons/sidemenu/file.svg",
            buttonId: 0,
            title: "文件管理",
            isSvg: true,
          ),
          // CustomSidemenuButton(
          //   iconUrl: null,
          //   buttonId: 1,
          //   title: "Todos",
          //   isSvg: false,
          // ),
          CustomSidemenuButton(
            iconUrl: "assets/icons/sidemenu/clean.svg",
            buttonId: 1,
            title: "Svg cleaner",
            isSvg: true,
          ),
          CustomSidemenuButton(
            iconUrl: "assets/icons/sidemenu/faker.svg",
            buttonId: 2,
            title: "Faker",
            isSvg: true,
          ),
          CustomSidemenuButton(
            iconUrl: "assets/icons/sidemenu/generator.svg",
            buttonId: 3,
            title: "Class Generator",
            isSvg: true,
          ),
          CustomSidemenuButton(
            iconUrl: "assets/icons/sidemenu/redis.svg",
            buttonId: 4,
            title: "Redis Client",
            isSvg: true,
          ),
          // const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
