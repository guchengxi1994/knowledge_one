// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:flutter_useful_widgets/flutter_useful_widgets.dart';

enum FakerTypes {
  address,
  // automotive,
  bank,
  barcode,
  color,
  company,
  creditCard,
  currency,
  // datetime,
  file,
  geo,
  internet,
  isbn,
  job,
  lorem,
  // misc,
  person,
  phoneNum,
  ssn,
  userAgent
}

FakerTypes? fromString(String s) {
  switch (s) {
    case "address":
      return FakerTypes.address;
    // case "automotive":
    //   return FakerTypes.automotive;
    case "bank":
      return FakerTypes.bank;
    case "barcode":
      return FakerTypes.barcode;
    case "color":
      return FakerTypes.color;
    case "company":
      return FakerTypes.company;
    case "creditCard":
      return FakerTypes.creditCard;
    case "currency":
      return FakerTypes.currency;
    // case "datetime":
    //   return FakerTypes.datetime;
    case "file":
      return FakerTypes.file;
    case "geo":
      return FakerTypes.geo;
    case "internet":
      return FakerTypes.internet;
    case "isbn":
      return FakerTypes.isbn;
    case "job":
      return FakerTypes.job;
    case "lorem":
      return FakerTypes.lorem;
    // case "misc":
    //   return FakerTypes.misc;
    case "person":
      return FakerTypes.person;
    case "phoneNum":
      return FakerTypes.phoneNum;
    case "ssn":
      return FakerTypes.ssn;
    case "userAgent":
      return FakerTypes.userAgent;

    default:
      return null;
  }
}

extension Conversion on FakerTypes {
  String toStr() {
    switch (this) {
      case FakerTypes.address:
        return "address";
      // case FakerTypes.automotive:
      //   return "automotive";
      case FakerTypes.bank:
        return "bank";
      case FakerTypes.barcode:
        return "barcode";
      case FakerTypes.color:
        return "color";
      case FakerTypes.company:
        return "company";
      case FakerTypes.creditCard:
        return "creditCard";
      case FakerTypes.currency:
        return "currency";
      // case FakerTypes.datetime:
      //   return "datetime";
      case FakerTypes.file:
        return "file";
      case FakerTypes.geo:
        return "geo";
      case FakerTypes.internet:
        return "internet";
      case FakerTypes.isbn:
        return "isbn";
      case FakerTypes.job:
        return "job";
      case FakerTypes.lorem:
        return "lorem";
      // case FakerTypes.misc:
      //   return "misc";
      case FakerTypes.person:
        return "person";
      case FakerTypes.phoneNum:
        return "phoneNum";
      case FakerTypes.ssn:
        return "ssn";
      case FakerTypes.userAgent:
        return "userAgent";
      default:
        return "";
    }
  }
}

class FakerTags extends StatefulWidget {
  const FakerTags({Key? key}) : super(key: key);

  @override
  State<FakerTags> createState() => FakerTagsState();
}

class FakerTagsState extends State<FakerTags> {
  List<Item> tagItems = [];
  int currentTagIndex = 1;

  @override
  void initState() {
    super.initState();
    tagItems.add(Item(index: 0, title: "添加一个新的条件"));
  }

  @override
  Widget build(BuildContext context) {
    return Tags(
      itemCount: tagItems.length,
      itemBuilder: (index) {
        final item = tagItems[index];

        if (item.index == 0) {
          return ItemTags(
            activeColor: Colors.blueGrey,
            color: Colors.blueGrey,
            highlightColor: Colors.blueGrey,
            textActiveColor: Colors.white,
            textColor: Colors.white,
            index: index,
            title: item.title ?? "",
            // icon: index == 0 ? ItemTagsIcon(icon: Icons.add) : null,
            removeButton: null,
            onPressed: (i) async {
              NewFakerItem? r = await showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const Center(
                      child: CreateFakerTagDialog(),
                    );
                  });

              if (r != null) {
                r.fakerType ??= FakerTypes.person;

                setState(() {
                  tagItems.insert(
                      tagItems.length - 1,
                      Item(
                          index: currentTagIndex,
                          title: "${r.key} : ${r.fakerType!.toStr()}"));
                  currentTagIndex += 1;
                });
              }
            },
          );
        }

        return ItemTags(
          activeColor: Colors.blueAccent,
          color: Colors.blueAccent,
          highlightColor: Colors.blueAccent,
          textActiveColor: Colors.white,
          textColor: Colors.white,
          index: index,
          title: item.title ?? "",
          // icon: index == 0 ? ItemTagsIcon(icon: Icons.add) : null,
          removeButton: ItemTagsRemoveButton(
            onRemoved: () {
              setState(() {
                tagItems.remove(item);
              });
              return true;
            },
          ),
          onPressed: (i) {
            print(i.title);
          },
        );
      },
    );
  }
}

class NewFakerItem {
  String locale;
  FakerTypes? fakerType;
  String key;

  NewFakerItem(
      {required this.fakerType, required this.key, required this.locale});
}

class CreateFakerTagDialog extends StatefulWidget {
  const CreateFakerTagDialog({Key? key}) : super(key: key);

  @override
  State<CreateFakerTagDialog> createState() => _CreateFakerTagDialogState();
}

class _CreateFakerTagDialogState extends State<CreateFakerTagDialog> {
  String? selectedType = null;
  String? selectedLang = null;
  final TextEditingController keyController = TextEditingController();
  @override
  void dispose() {
    keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      width: 320,
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleDropdownButton(
              buttonWidth: 280,
              style: const TextStyle(
                  color: Color.fromARGB(255, 159, 159, 159), fontSize: 10),
              hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
              icon: const Icon(Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 232, 232, 232)),
              buttonHeight: 30,
              buttonDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                  border: Border.all(
                      color: const Color.fromARGB(255, 232, 232, 232))),
              hint: "选择类型",
              value: selectedType,
              dropdownItems: FakerTypes.values.map((e) => e.toStr()).toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              }),
          const SizedBox(
            height: 5,
          ),
          SimpleDropdownButton(
              buttonWidth: 280,
              style: const TextStyle(
                  color: Color.fromARGB(255, 159, 159, 159), fontSize: 10),
              hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 159, 159, 159), fontSize: 12),
              icon: const Icon(Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 232, 232, 232)),
              buttonHeight: 30,
              buttonDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                  border: Border.all(
                      color: const Color.fromARGB(255, 232, 232, 232))),
              hint: "选择语言",
              value: selectedLang,
              dropdownItems: const ['zh_CN', 'en'],
              onChanged: (value) {
                setState(() {
                  selectedLang = value;
                });
              }),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 232, 232, 232)),
                borderRadius: BorderRadius.circular(9)),
            height: 30,
            width: 280,
            child: TextField(
              style: const TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 159, 159, 159)),
              controller: keyController,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Color.fromARGB(255, 159, 159, 159)),
                contentPadding: EdgeInsets.only(bottom: 17, left: 5),
                hintText: "请输入key值",
                border: InputBorder.none,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            padding: const EdgeInsets.only(bottom: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop(null);
                    },
                    child: Container(
                      width: 73,
                      height: 21,
                      padding: const EdgeInsets.only(bottom: 1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(7)),
                      child: const Center(
                        child: Text(
                          "取消",
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 12),
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () {
                      if (selectedType == null || selectedLang == null) {
                        return;
                      }

                      Navigator.of(context).pop(NewFakerItem(
                          fakerType: fromString(selectedType!),
                          key: keyController.text,
                          locale: selectedLang!));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 1),
                      width: 73,
                      height: 21,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(7)),
                      child: const Center(
                        child: Text(
                          "确定",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
