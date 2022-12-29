import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:some_ui/src/tip/controller.dart';
import 'package:some_ui/src/tip/new_tip_form.dart';

import 'select_tip_form.dart';

class CustomTip extends StatelessWidget {
  const CustomTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TipController(initModels: () async {
                  return [];
                })
                  ..init()),
      ],
      builder: (context, child) {
        if (context.watch<TipController>().status == TipStatus.create) {
          return NewTipForm();
        } else {
          return SelectTipForm(
            onItemClicked: () async {},
          );
        }
      },
    );
  }
}
