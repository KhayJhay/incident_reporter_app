class Floodreport {
  String id;
  final String name;
  final String body;
  final String date;
  final String time;

  Floodreport({
    this.id = '',
    required this.name,
    required this.body,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'body': body,
        'date': date,
        'time': time,
      };

  static Floodreport fromJson(Map<String, dynamic> json) => Floodreport(
      id: json['id'],
      name: json['name'],
      body: json['body'],
      date: json['date'],
      time: json['time']);
}
