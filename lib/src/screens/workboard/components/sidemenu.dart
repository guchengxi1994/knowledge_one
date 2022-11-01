import 'package:flutter/material.dart';
import 'package:knowledge_one/app_style.dart';

import 'custom_sidemenu_button.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key? key}) : super(key: key);
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30, left: 24, top: 20),
      controller: controller,
      child: Container(
        width: AppStyle.sideMenuWidth,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "日常工作",
              style: AppStyle.sidebarLabelStyle2,
            ),
            const SizedBox(
              height: 8,
            ),
            buildFilesButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildFilesButtons() {
    return SizedBox(
      child: Column(
        children: const [
          CustomSidemenuButton(
            iconUrl: null,
            buttonId: 0,
            title: "文件管理",
            isSvg: false,
          ),
          CustomSidemenuButton(
            iconUrl: null,
            buttonId: 1,
            title: "Todos",
            isSvg: false,
          ),
        ],
      ),
    );
  }
}
