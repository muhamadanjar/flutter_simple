class Booking {
  final String id;
  final String name;
  final String date;
  final String time;
  final int numberOfPeople;

  Booking({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.numberOfPeople,
  });

  @override
  String toString() {
    return 'Booking{id: $id, name: $name, date: $date, time: $time, numberOfPeople: $numberOfPeople}';
  }
}