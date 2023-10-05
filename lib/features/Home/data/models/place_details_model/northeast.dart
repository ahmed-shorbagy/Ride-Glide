import 'package:equatable/equatable.dart';

class Northeast extends Equatable {
  final double? lat;
  final double? lng;

  const Northeast({this.lat, this.lng});

  factory Northeast.fromJson(Map<String, dynamic> json) => Northeast(
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
