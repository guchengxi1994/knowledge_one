// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knowledge_one/common/app_style.dart';
import 'package:knowledge_one/common/routers.dart';
import 'package:knowledge_one/initial/first.dart';
import 'package:knowledge_one/initial/second.dart';
import 'package:knowledge_one/initial/third.dart';
import 'package:knowledge_one/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'initial_controller.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  int currentIndex = 0;
  static const duration = Duration(milliseconds: 200);
  final LocalStorage storage = LocalStorage();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => InitialController())],
      builder: (context, child) {
        return Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 40),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppStyle.appBlue),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: PageView(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    FirstScreen(),
                    SecondScreen(),
                    ThirdScreen()
                  ],
                ),
              )),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                      visible: currentIndex != 0,
                      maintainAnimation: true,
                      maintainSize: true,
                      maintainState: true,
                      child: ElevatedButton(
                          onPressed: () {
                            if (currentIndex == 0) {
                              return;
                            }
                            currentIndex = currentIndex - 1;
                            controller.animateToPage(currentIndex,
                                duration: duration, curve: Curves.linear);
                            setState(() {});
                          },
                          child: const SizedBox(
                            width: 100,
                            child: Center(
                              child: Text("上一页"),
                            ),
                          ))),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const WormEffect(
                      dotHeight: 16,
                      dotWidth: 16,
                      type: WormType.thin,
                      // strokeWidth: 5,
                    ),
                  ),
                  currentIndex == 2
                      ? ElevatedButton(
                          onPressed: () async {
                            final path =
                                File(Platform.resolvedExecutable).parent;
                            final dbFile = File("${path.path}/db_config.toml");
                            await dbFile.writeAsString(context
                                .read<InitialController>()
                                .generateMysql());

                            Navigator.of(context).pushNamed(Routers.mainScreen);
                          },
                          child: const SizedBox(
                            width: 100,
                            child: Center(
                              child: Text("确定"),
                            ),
                          ))
                      : ElevatedButton(
                          onPressed: () {
                            if (currentIndex == 2) {
                              return;
                            }
                            currentIndex = currentIndex + 1;
                            controller.animateToPage(currentIndex,
                                duration: duration, curve: Curves.linear);
                            setState(() {});
                          },
                          child: const SizedBox(
                            width: 100,
                            child: Center(
                              child: Text("下一页"),
                            ),
                          )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
