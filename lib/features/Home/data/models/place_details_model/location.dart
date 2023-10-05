import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double? lat;
  final double? lng;

  const Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
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
