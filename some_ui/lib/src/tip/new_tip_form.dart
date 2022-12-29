import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller.dart';

class NewTipForm extends StatelessWidget {
  NewTipForm({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 20)],
      ),
      child: buildChild(context),
    );
  }

  Widget buildChild(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildFormTitle(context),
        Divider(
          color: Colors.grey[300],
        ),
        const SizedBox(
          height: 15,
        ),
        buildTextField(),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: context
              .select<TipController, List<Color>>(
                  (value) => value.reservedColors)
              .map((e) => _selectedCircle(context, e))
              .toList(),
        ),
        const SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: () {
            context
                .read<TipController>()
                .addModel(TipModel(tipName: controller.text));
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.grey[300]!,
              ),
              width: 270,
              height: 50,
              child: const SizedBox(
                width: 200,
                height: 40,
                child: Center(
                  child: Text(
                    "确定",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              )),
        )
      ],
    );
  }

  Widget buildFormTitle(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              context.read<TipController>().swtichStatus();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.chevron_left,
                color: Colors.grey[300]!,
              ),
            ),
          ),
          const Text(
            "新建标签",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.close,
                  color: Colors.grey[300]!,
                )),
          )
        ],
      ),
    );
  }

  Widget buildTextField() {
    return Container(
      width: 270,
      height: 40,
      color: Colors.white,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        controller: controller,
        decoration: const InputDecoration(
          // labelText: "用户名",
          hintText: "标签名称",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _selectedCircle(BuildContext context, Color color) {
    return InkWell(
      onTap: () {
        context.read<TipController>().changeSelectedColorIndex(color);
      },
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: context.select<TipController, Color>(
                    (value) => value.currentColor) ==
                color
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
