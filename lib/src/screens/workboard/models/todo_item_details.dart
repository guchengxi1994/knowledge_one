enum ItemDetailsStatus { delay, undergoing, done, planned }

extension ConvertWithString on ItemDetailsStatus {
  static ItemDetailsStatus fromString(String s) {
    switch (s) {
      case "未开始":
        return ItemDetailsStatus.planned;
      case "已完成":
        return ItemDetailsStatus.done;
      case "延迟":
        return ItemDetailsStatus.delay;
      case "进行中":
        return ItemDetailsStatus.undergoing;
      default:
        return ItemDetailsStatus.planned;
    }
  }
}

abstract class AbsItemDetails {
  int index;
  String status;
  AbsItemDetails({required this.index, required this.status});

  void markedAsDone();
}

class BaseItemDetails extends AbsItemDetails {
  BaseItemDetails(
      {required int index,
      required String status,
      required this.content,
      required this.from,
      required this.to})
      : super(index: index, status: status);

  String content;
  DateTime from;
  DateTime to;

  @override
  void markedAsDone() {
    status = "已完成";
  }
}
