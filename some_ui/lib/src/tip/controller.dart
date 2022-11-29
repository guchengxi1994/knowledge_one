import 'package:flutter/material.dart';

enum TipStatus { choose, create }

typedef InitModels = Future<List<TipModel>> Function();

class TipModel {
  final String tipName;
  Color? tipColor;
  TipModel({this.tipColor, required this.tipName});

  @override
  bool operator ==(Object other) {
    if (other is! TipModel) {
      return false;
    }
    return other.tipName == tipName;
  }

  @override
  int get hashCode => tipName.hashCode;
}

class TipController extends ChangeNotifier {
  TipStatus status = TipStatus.choose;
  List<TipModel> models = [];
  final InitModels? initModels;
  TipController({required this.initModels});

  List<Color> reservedColors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.blueGrey,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.redAccent
  ];

  int selectedColorIndex = 0;
  Color get currentColor => reservedColors[selectedColorIndex];

  changeSelectedColorIndex(Color color) {
    selectedColorIndex = reservedColors.indexOf(color);
    notifyListeners();
  }

  init() async {
    if (initModels != null) {
      models = await initModels!();
    } else {
      models = [];
    }
    notifyListeners();
  }

  swtichStatus() {
    if (status == TipStatus.choose) {
      status = TipStatus.create;
    } else {
      status = TipStatus.choose;
    }
    notifyListeners();
  }

  addModel(TipModel model) {
    if (!models.contains(model)) {
      model.tipColor ??= currentColor;
      models.add(model);
      notifyListeners();
    }
  }

  removeModel(TipModel model) {
    if (models.contains(model)) {
      models.remove(model);
      notifyListeners();
    }
  }
}
