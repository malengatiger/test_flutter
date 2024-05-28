import 'package:json_annotation/json_annotation.dart';

part 'chart_data.g.dart';

@JsonSerializable()
class ChartData {
  final List<Values>? values;

  const ChartData({
    this.values,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) =>
      _$ChartDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChartDataToJson(this);
}

@JsonSerializable()
class Values {
  final int? x;
  final double? y;

  const Values({
    this.x,
    this.y,
  });

  factory Values.fromJson(Map<String, dynamic> json) =>
      _$ValuesFromJson(json);

  Map<String, dynamic> toJson() => _$ValuesToJson(this);
}
