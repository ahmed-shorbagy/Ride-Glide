import 'package:equatable/equatable.dart';

import 'geometry.dart';

class Result extends Equatable {
  final String? formattedAddress;
  final Geometry? geometry;
  final String? name;

  const Result({this.formattedAddress, this.geometry, this.name});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        formattedAddress: json['formatted_address'] as String?,
        geometry: json['geometry'] == null
            ? null
            : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'formatted_address': formattedAddress,
        'geometry': geometry?.toJson(),
        'name': name,
      };

  @override
  List<Object?> get props => [formattedAddress, geometry, name];
}
