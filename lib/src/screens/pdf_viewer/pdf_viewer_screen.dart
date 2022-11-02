import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen(
      {Key? key, required this.filePath, required this.fileName})
      : super(key: key);
  final String filePath;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_outlined,
              color: Colors.black,
              size: 30,
            )),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        centerTitle: false,
        title: Text(
          fileName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SfPdfViewer.file(File(filePath)),
    );
  }
}
