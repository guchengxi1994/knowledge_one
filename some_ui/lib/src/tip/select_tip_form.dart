import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:some_ui/src/tip/controller.dart';

typedef OnItemClicked = Future<void> Function();

class SelectTipForm extends StatefulWidget {
  const SelectTipForm({Key? key, required this.onItemClicked})
      : super(key: key);
  final OnItemClicked? onItemClicked;

  @override
  State<SelectTipForm> createState() => _SelectTipFormState();
}

class _SelectTipFormState extends State<SelectTipForm> {
  final TextEditingController controller = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.text != "" && !isSearching) {
        setState(() {
          isSearching = true;
        });
      }
      if (controller.text == "" && isSearching) {
        setState(() {
          isSearching = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      // height: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 20)],
      ),
      child: buildChild(),
    );
  }

  Widget buildChild() {
    List<TipModel> models = context.watch<TipController>().models;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildFormTitle(),
        SizedBox(
          width: 300,
          child: Divider(
            thickness: 2,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if (!isSearching)
          Column(
            children: models.map((e) => _buildItem(e)).toList(),
          )
      ],
    );
  }

  Widget buildFormTitle() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 200,
            height: 40,
            color: Colors.white,
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              controller: controller,
              decoration: const InputDecoration(
                // labelText: "用户名",
                hintText: "搜索标签",
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.read<TipController>().swtichStatus();
            },
            child: Icon(
              Icons.add_circle_outline,
              color: Colors.grey[300]!,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(TipModel model) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 5,
            height: 5,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: model.tipColor),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(model.tipName)
        ],
      ),
    );
  }
}
