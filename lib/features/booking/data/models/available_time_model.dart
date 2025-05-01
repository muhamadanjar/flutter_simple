
import '../../domain/entities/available_time.dart';

class AvailableTimeModel extends AvailableTime {
  AvailableTimeModel({required super.start, required super.end, String? name = ""})
      : super(name: '-');

  factory AvailableTimeModel.fromJson(Map<String, dynamic> json) {
    final name = "${json['start']} + ' - ' + ${json['end']}";
    return AvailableTimeModel(
      start: json['start'],
      end: json['end'],
      name: name,
    );
  }


  AvailableTime toDomain() {
    return AvailableTime(
        start: start,
        end: end,
        name: "$start - $end",
    );
  }
}
