import 'package:flutter/material.dart';
import 'package:knowledge_one/app_style.dart';

import '../models/models.dart';

class BaseFileWidget<T extends BaseFileEntity> extends StatelessWidget {
  const BaseFileWidget({Key? key, required this.data}) : super(key: key);
  final T data;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: AppStyle.fileWidgetSize,
      height: AppStyle.fileWidgetSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: AppStyle.iconSize,
            height: AppStyle.iconSize,
            child: Image.asset(
              data.iconPath!,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Tooltip(
            // margin: const EdgeInsets.only(top: 20),
            message: data.name,
            child: Text(
              data.name,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
