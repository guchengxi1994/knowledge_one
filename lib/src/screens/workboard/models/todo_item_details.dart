enum ItemDetailsStatus { delay, undergoing, done, planned }

abstract class AbsItemDetails {
  int index;
  ItemDetailsStatus status;
  AbsItemDetails({required this.index, required this.status});

  void markedAsDone();
}

class BaseItemDetails extends AbsItemDetails {
  BaseItemDetails(
      {required int index,
      required ItemDetailsStatus status,
      required this.content,
      required this.from,
      required this.to})
      : super(index: index, status: status);

  String content;
  DateTime from;
  DateTime to;

  @override
  void markedAsDone() {
    status = ItemDetailsStatus.done;
  }
}
