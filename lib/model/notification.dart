class NotificationPop {
  final int? id;
  final String? title;
  final String? description;
  final String? date;

  NotificationPop({this.id, this.title, this.description, this.date});

  factory NotificationPop.fromJson(Map<String, dynamic> json) {
    return NotificationPop(
      id: json['id'],
      title: json['titulo'],
      description: json['descricao'],
      date: json['data'],
    );
  }
}