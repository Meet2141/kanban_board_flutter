class KanbanDataModel {
  final String? groupId;
  final String? itemId;
  final String? title;
  final String? description;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? startDate;
  final DateTime? endDate;

  KanbanDataModel({
    this.groupId,
    this.itemId,
    this.title,
    this.description,
    this.createdDate,
    this.updatedDate,
    this.startDate,
    this.endDate,
  });
}
