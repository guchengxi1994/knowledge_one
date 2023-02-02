import 'dart:io';

import 'package:flutter/material.dart';

class PreviewDialog extends StatefulWidget {
  const PreviewDialog(
      {Key? key,
      required this.height,
      required this.width,
      required this.filePath})
      : super(key: key);
  final double width;
  final double height;
  final String filePath;

  @override
  State<PreviewDialog> createState() => _PreviewDialogState();
}

class _PreviewDialogState extends State<PreviewDialog> {
  late String fileData = "";

  Future _loadData() async {
    File f = File(widget.filePath);
    fileData = await f.readAsString();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        width: widget.width,
        height: widget.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Container()),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    )),
              ],
            ),
            SingleChildScrollView(
                child: FutureBuilder(
              future: _loadData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Text(
                  fileData,
                  maxLines: null,
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
