import 'package:equatable/equatable.dart';

import 'location.dart';
import 'viewport.dart';

class Geometry extends Equatable {
  final Location? location;
  final Viewport? viewport;

  const Geometry({this.location, this.viewport});

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        viewport: json['viewport'] == null
            ? null
            : Viewport.fromJson(json['viewport'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        'viewport': viewport?.toJson(),
      };

  @override
  List<Object?> get props => [location, viewport];
}
