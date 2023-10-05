import 'package:equatable/equatable.dart';

class Southwest extends Equatable {
  final double? lat;
  final double? lng;

  const Southwest({this.lat, this.lng});

  factory Southwest.fromJson(Map<String, dynamic> json) => Southwest(
        lat: (json['lat'] as num?)?.toDouble(),
        lng: (json['lng'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  @override
  List<Object?> get props => [lat, lng];
}
